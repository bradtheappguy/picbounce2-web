#TODO find out which metods should be private and make them so
#TODO move the Twitter credentials
#TODO move the AWS initilization
#TOFO add a visiability enum attribute

TWITTER_API_KEY = "IVAXfzLx6AbTeTAKyF2NA"
TWITTER_API_SECRET = "fEFil1sw8gupwTSIeZHbNqNBSZH3NOyJWzenH9ajHs"

require 'twitter'
require 'httpclient'
require 'json'
require 'aws/s3'

class Post < ActiveRecord::Base  
  
  def created
    created_at.to_f
  end

  
  set_primary_key :id

  acts_as_api

  has_many :flags 
  has_many :comments
  belongs_to :user
  has_many :authentications

 #default_scope :conditions => {:deleted => nil}
 
  scope :public, lambda {
    joins(:user).
    where("users.twitter_screen_name IS NOT NULL")
  }

  
  default_scope limit(25)
  scope :recent, public.limit(9).order("created_at desc")
  #scope :popular, lambda {where("view_count > -1"). order("id desc"). limit(100)}
  scope :popular, public.where('view_count > 1').order("created_at desc").limit(100)
  
  attr_accessor :photo
  attr_accessor :key
  attr_accessor :twitter_oauth_token
  attr_accessor :twitter_oauth_secret
  attr_accessor :facebook_access_token
  
  before_create :load_from_aws, :set_uuid, :process_photos
  after_create :trigger_uploads
  
  before_update :trigger_deletes
  
  
  after_initialize :default_values

 


  def self.find_public(*args)
    args << 
    self.find()
  end
  
  def self.find_deleted_by_code(id)
    photo = Post.with_exclusive_scope {self.find_by_code(id)}
    photo.uuid = nil
    photo
  end
  
  # The filesystem path used to store the result of the image magick resizing before uploading
  def photo_temp_path(style)
    "tmp/#{self.uuid}-#{style}.jpg" 
  end
  
  
  def set_uuid
    self.uuid = rand(2**128).to_s(16)
    true
  end
  def flagged?(user)
    return false unless user
    found = false
    self.flags.each{|f| 
       if f.user == user
          found = true 
       end
       
    }
    return found
  end
    
  # Generates the publicly avaiale URLs where the image is available after being saved to S3  
  def post_url(style)
    "http://s3.amazonaws.com/com.clixtr.picbounce/photos/#{self.uuid}/#{style}.jpg"
  end
  
  
  # Resize the uploaded photo using the ImageMagik command line and then upload to S3
  def process_photos
    if (ptype == "photo")
      #These are the ImageMagik command line options
      styles = { :thumb => '-define jpeg:size=5000x5000 -resize "80x80^" -extent "80x80" -auto-orient -quality 90', 
                 :big   => '-resize "600x600>" -auto-orient' }  

      styles.each_pair do |style, options|
        cmd = "convert #{self.photo.path} #{options} #{photo_temp_path(style)}"
        puts cmd
        exit_status = system(cmd)
        #raise "Image Resizing Failed #{exit_status} #{cmd}" if !exit_status
        #TODO move the establish connection somewhere better, perhaps an initilizer
        AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIIZEL3OLHCBIZBBQ', :secret_access_key => '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')
        AWS::S3::S3Object.store("/photos/#{self.uuid}/#{style}.jpg", open(photo_temp_path(style)), 'com.clixtr.picbounce', {:access => :public_read})
      end
    end
  end    
  
  
  # Trigger the upoads to facebook to twitter in parallel threads, but wait until both are don
  # before continuing
  def trigger_uploads
    if (ptype == "photo")
      logger.debug "trigger uploads"
      threads = []

      threads << Thread.new {
        fb_timer = Time.now
        upload_to_facebook
        logger.debug '** FB ** ' + ((Time.now - fb_timer)  ).to_s + ' sec'
      }
      threads << Thread.new {
        tw_timer = Time.now
        upload_to_twitter
        logger.debug '** TW ** ' + ((Time.now - tw_timer)  ).to_s + ' sec'
      }
      threads.each do |t|
        t.join
      end
      save_timer = Time.now
      self.save
      logger.debug 'save ' + ((Time.now - save_timer)  ).to_s + ' sec'
    end
  end
  
  
  # Trigger the deletes to facebook to twitter in parallel threads, but wait until both are don
  # before continuing
  def trigger_deletes
    if self.deleted
      logger.debug "trigger deletes"
      threads = []
      
      threads << Thread.new {
        tw_timer = Time.now
        delete_from_twitter
        logger.debug '** TW ** ' + ((Time.now - tw_timer)  ).to_s + ' sec'
      }
      threads << Thread.new {
        tw_timer = Time.now
        delete_from_facebook
        logger.debug '** FB ** ' + ((Time.now - tw_timer)  ).to_s + ' sec'
      }
      threads.each do |t|
        t.join
      end
    end
  end
  
  
  #trim the caption to 120 chars to fit in a tweet and append the url
  def twitter_caption
    if caption
      return caption[0,120] + " http://picbounce.com/#{code}"
    else
      return "http://picbounce.com/#{code}"
    end
  end
  
  #TODO move to a rake task 
  #This can probabally be safeley removed now, this was put here as a hack to work around the 30 second migration limit imposed by heroku 
  def facebook_user_id
    uid = read_attribute(:facebook_user_id)
    if !uid
      a = self.facebook_access_token.split('-')[1] if self.facebook_access_token
      b = a.split('|')[0] if a
      uid = b 
      write_attribute(:facebook_user_id, uid)
    end
    return uid
  end
  
  
  def upload_to_twitter
    if twitter_oauth_token && twitter_oauth_secret
      logger.debug "** TW ** "+"Uploading To Twitter"
      begin
        Twitter.configure do |config|
          config.consumer_key = TWITTER_API_KEY
          config.consumer_secret = TWITTER_API_SECRET
          config.oauth_token = twitter_oauth_token
          config.oauth_token_secret = twitter_oauth_secret
        end
        client = Twitter::Client.new
        response = client.update(self.twitter_caption)
        pp response
        user = response['user']
        self.block = 1 if user['protected']
        
        #TODO add a migration so we can save these
        #Twitter user id = response.user.id
        #tweet_id = response.id
        self.twitter_post_id = response.id
        self.twitter_screen_name = response.user.screen_name
        logger.debug response.user

        block_from_homepage_if_banned
        
     
        self.twitter_post_status_code = 200
        self.twitter_post_status_body = response.id
      rescue Exception => exc
        self.twitter_post_status_code = 500
        self.twitter_post_status_body = exc.message
      end
      logger.debug "** TW ** "+"Uploading To Twitter"
    else
      logger.debug "** TW ** "+"twitter not needed"
    end
  end
  
  def delete_from_twitter
    if twitter_oauth_token && twitter_oauth_secret
      begin
        Twitter.configure do |config|
          config.consumer_key = TWITTER_API_KEY
          config.consumer_secret = TWITTER_API_SECRET
          config.oauth_token = twitter_oauth_token
          config.oauth_token_secret = twitter_oauth_secret
        end
        client = Twitter::Client.new
        response = client.status_destroy(self.twitter_post_id)
        pp response
        
        self.twitter_post_status_code = 200
        self.twitter_post_status_body = response.id
      rescue Exception => exc
        self.twitter_post_status_code = 500
        self.twitter_post_status_body = exc.message
      end
      logger.debug "** TW ** "+"Deleting From Twitter"
    else
      logger.debug "** TW ** "+"twitter not needed"
    end
  end
  
  
  ## Returns the result of a HTTPClient object that posts our data to facebook
  ## 
  ## if the user (destinguished by iphone device id) has previouslly uploaded a photo before Nov 23, we post all
  ## future photos to a photo album.  For new users, we make the photo visiable on picbounce.com and post a status
  ## update that points to the picbounce url. 
  def facebook_http_post
      p = Post.find(:first, :order => :id, :conditions => ['device_id = ?', device_id])
      logger.debug "Checking for legacy Facebook Support"
     if (p && device_id != 'baa0e2136a3cfa101fd8440f2a4df0ca56e76797') #Special case for customer
      if (p && device_id != '048b2136b4023f50d23c0309d7a49bf3af2266ef')  #The device id is a Special Case for Ted Vicky (See https://www.pivotaltracker.com/story/show/6850999)
        if (p.created_at < Date.parse('Tue, 23 Nov 2010 23:39:10 UTC 00:00') || device_id == '61fe1b2b5e52a1f348e8800015c9a50d680729ee')
          logger.debug "Saving to Album"
          file_to_upload = open("tmp/#{uuid}-big.jpg")
          return HTTPClient.post 'https://graph.facebook.com/me/photos', {:message => caption, :access_token => facebook_access_token, :source => file_to_upload}  
        end
      end
     end 
    #upload the photo to the a facebook photo album called 'PicBounce For iPhone Photos'.  Let facebook automatically update the users stream                                                                                                                                                                                       
    thumb_url = self.post_url(:thumb)
    logger.debug "Saving to PicBounce and updating feed for code: #{code} thumburl: #{thumb_url}"
    return HTTPClient.post 'https://graph.facebook.com/me/feed', {:access_token => facebook_access_token,
                                                                      :message => caption,
                                                                      :link => "http://picbounce.com/#{code}",
                                                                      :picture => thumb_url,
                                                                      :name => 'PicBounce Photo',
                                                                      :caption => ' ',
                                                                      :description => ' ',
                                                                      :actions => "{\"name\": \"View on PicBounce\", \"link\": \"http://picbounce.com/#{code}\" }",
                                                                      :privacy => '{"value": "EVERYONE"}'
    }
  end
  
  def facebook_http_delete
    url =  ('https://graph.facebook.com/'+ facebook_photo_id + '?access_token=' + URI.escape(facebook_access_token) )
    puts url
    return HTTPClient.delete url
  end
  
  
  def delete_from_facebook
    if facebook_access_token
      logger.debug "deleting from facebook with access_token: #{facebook_access_token}"
      
      a = self.facebook_access_token.split('-')[1] if self.facebook_access_token
      b = a.split('|')[0] if a
      #self.facebook_user_id = b
      
      resp = self.facebook_http_delete
      self.facebook_post_status_code = resp.status
      self.facebook_post_status_body = resp.body 
      puts self.facebook_post_status_body
      
    else  
      logger.debug("NOT DELETING FROM FB - NO TOKEN")
    end
  end
  
  def upload_to_facebook
    if facebook_access_token
      logger.debug "uploading to facebook with caption: #{caption} access_token: #{facebook_access_token}"
      
      a = self.facebook_access_token.split('-')[1] if self.facebook_access_token
      b = a.split('|')[0] if a
      #self.facebook_user_id = b
      
      resp = self.facebook_http_post
      self.facebook_post_status_code = resp.status
      self.facebook_post_status_body = resp.body  
      logger.debug resp.body
      if resp.status == 200
        json = JSON.parse(resp.body)
        self.facebook_photo_id = json['id'] 
      end
    else  
      logger.debug("NOT SAVING TO FB - NO TOKEN")
    end
  end
  
  
def twitter_avatar_url
  attr = read_attribute(:twitter_avatar_url)
  if !attr
    url = Twitter.user(self.twitter_screen_name).profile_image_url
    update_attribute(:twitter_avatar_url, url)
    return url
  end
  return attr
end
  
  
  
  # Poor Tyrekus, he is our only banned user.  If we need to we will evantually make a table for this.
  # Also once, we are saving the Twitter ID we should use that not the screen anme as they are not unique and can be changed
  def block_from_homepage_if_banned 
    if self.twitter_screen_name == "Tyrekus"
      logger.debug "** BL ** "+"Blocking photo from home page (Ban-Hammer)"
      self.block = 1
    end
  end
  
  
  def facebook_post_status_msg
    translate_facebook_error(self.facebook_post_status_code,self.facebook_post_status_body)
  end
  
  def twitter_post_status_msg
    translate_twitter_error(self.twitter_post_status_code,self.twitter_post_status_body)
  end
  
  def general_status
     if (self.facebook_post_status_code != nil && self.facebook_post_status_code != 200) || (self.twitter_post_status_code != nil && self.twitter_post_status_code != 200)
      400
    else
      200 
    end
  end
  
  
  def translate_facebook_error(fb_code,fb_message)   
    return nil unless fb_message
    if fb_code != 200
      json = JSON.parse(fb_message)
      error = json['error'] 
      if error
        type = error['type']
        message = error['message']
        if type == "OAuthException"
          if message == "Error validating access token."
            return "Your Facebook connection is screwed up! In Settings: try logging out and back into Facebook. "
          elsif message == "(#1) An unknown error occurred"
            return "Your Facebook connection is screwed up! Try again later or in Settings: logout and back into Facebook. "
          elsif message == "(#341) Feed action request limit reached"
            return "Wow! You have reached your daily Facebook upload limit (we are working with Facebook to try and increase it). Please try again later. "
          end
          return "Your Facebook connection is screwed up! Try again later or in Settings: logout and back into Facebook. "
        elsif type == "DfsException"
          return "Uh oh, Facebook is down! Please try again later. "
        end
      end
      
      return "Uh oh, Facebook is down! Please try again later. "
    else
      return ((fb_message != nil)?(fb_message.to_s + " "):(""))
    end
  end
  
  def translate_twitter_error(tw_code,tw_message)
    logger.debug tw_message
    if tw_code != 200
      if tw_message == "(401): Unauthorized - Incorrect signature" 
        return "Your Twitter connection is screwed up! Try again later or in Settings: logout and back into Twitter. "
      end
     return "Uh oh, Twitter is down! Please try again later. "
    else
      return ((tw_message != nil)?(tw_message.to_s + " "):(""))
    end
  end
  
  def self.find_popular 
    Post.popular.sort_by {rand}
  end

  def twitter_avatar_url
    "foo"
  end
  
  def to_param
    code
  end
  
  def flags_count
    1
  end
  
  def bounces_count
    2
  end
  
  def comments_count
    3
  end
  
  def tagged_people_count
    4
  end
  
  def tags_count
    5
  end


  def load_from_aws
    if (ptype == "photo")
      puts key
      open("tmp/#{code}.jpg", 'wb') do |file|
        file << open("http://s3.amazonaws.com/com.picbounce.incoming/#{key}").read
        puts file.path
        self.photo = file
      end
    end
  end

  mount_uploader :image, ImageUploader
  
  
   private
    def default_values
      self.ptype ||= "photo"
    end
end

#EOF 
