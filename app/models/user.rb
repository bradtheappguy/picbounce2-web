class User < ActiveRecord::Base
  include Sluggable
  include Rails.application.routes.url_helpers
  
  
  
  after_initialize :default_values
  
  acts_as_api
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable, :token_authenticatable, :validatable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :slug, :is_current_user
  has_many :devices, :class_name => 'APN::Device'
  has_many :posts, :limit => 100, :order => 'created_at desc'
  has_many :all_posts, :class_name => 'Post'  
  has_many :followings 
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follower_id"
  has_many :followers,  :through => :followings       
  has_many :followeds,  :through => :inverse_followings, :source => :user
  has_many :user_filters
  has_many :filters,  :through => :user_filters
  
  def feed
    #TODO:optimize
    @photos = followeds.includes(:posts).collect(&:posts).flatten.reverse[0..50]
  end
  
  has_many :services, :dependent => :destroy do
    def facebook
      target.detect{|t| t.provider == 'facebook'}
    end

    def twitter
      target.detect{|t| t.provider == 'twitter'}
    end
  end
  
  
  before_save :ensure_authentication_token

  
  #JSON TEmplates
  api_accessible :base do |template|
   template.add :display_name
   template.add :raw_slug_text, :as => :screen_name
   template.add :avatar
   template.add :id
   #template.add :is_following?, :as => :following
   #template.add :follows_me?, :as => :follows_me
  end
   
  def self.find_by_slug_or_id(slug_or_id)
    numeric = (slug_or_id.to_i.to_s == slug_or_id)
    user = User.find_by_slug(slug_or_id.to_s)
    if user.nil? && numeric
      user = User.find_by_id(slug_or_id.to_i)
    end
    return user
  end
  
  def post_count
    self.all_posts.count
  end

  
  def followed_by_count
    self.followings.count
  end

   
  def following_count
    self.inverse_followings.count
  end

  
  def badges_count
    0
  end

  
  def last_location
    "San Francsico"
  end
  
  def is_following?(user)
    true
  end
  
  def follows?(user)
    true
  end
  
  def avatar 
    if twitter_avatar_url
      return twitter_avatar_url
    else
      return root_url+"images/empty_avatar_large.png"
    end
    #services.each do |service|  
    #  return service.image if service.image
    #end
  end

  def created
    created_at.to_f
  end
  
  def posts_after(timestamp,limit=10)
    Post.find(:all, :conditions => ["user_id = ? and created_at > ?", self.id, Time.at(timestamp) ], :order => 'created_at asc', :limit => limit)
  end
  
  def posts_before(timestamp,limit=10)
    Post.find(:all, :conditions => ["user_id = ? and created_at < ?", self.id, Time.at(timestamp) ], :order => 'created_at desc', :limit => limit)
  end

  def posts_with_offset(skip,limit)
    Post.find(:all, :conditions => ["user_id = ?", self.id ], :order => 'created_at desc', :offset => skip,  :limit => limit)
  end


      
  def photo
  end

  
  def photo=(i)
  end

  
  #def password_required?
  #  (authentications.empty? || !password.blank?) && super
  #end

  before_validation :generate_slug, :on => :create
  
  validates_uniqueness_of :slug
  validates_length_of :slug, :minimum => 1

  has_many :sharings

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.services.build(:provider => data['provider'], :uid => data['uid'])
      end
    end
  end

  def slug_source
    :raw_slug_text
  end

  def slug_scope
    []
  end

  def raw_slug_text
    return slug unless slug.nil?
    return name unless name.blank?
    return 'user'
  end

  def to_param
    slug || id.to_s
  end

  def apply_omniauth(omniauth)
    self.name = omniauth['user_info']['name'] if self.name.blank?
    self.email = omniauth['user_info']['email'] if self.email.blank? && omniauth['user_info']['email']
    
    services.build(:provider => omniauth['provider'], 
                      :uid => omniauth['uid'], 
                      :omniauth => omniauth)
  end


  #allows for account creation from twitter & fb
  #allows saves w/o password
  def password_required?
    return false
    #(!persisted? && servicesempty?) || password.present? || password_confirmation.present?
  end

  #allows for account creation from twitter
  def email_required?
    services.empty?
  end

  def remember_me
    super.nil? ? false : true
  end

  def tweet!(message, url=DEFAULT_SHARE_URL)
    twitter_client.update truncated_message_with_url(message, url)
  end

  def fb_post!(message, name=DEFAULT_FB_POST_NAME,
          description="TODO", url=DEFAULT_SHARE_URL)
   
    options = {'access_token' => services.facebook.token,
               'message' => message,
               'link' => url,
               #'picture' => img,
               'name' => name,
               'caption' => url,
               'description' => description
    }
    RestClient.post(URI.escape("https://graph.facebook.com/me/feed/"), options)
  end
  
  def external_photos(service_name,after=nil)
    puts "/n/n/n/n/n"
    puts service_name
    puts "/n/n/n/n/n"
    if service_name == 'facebook'
      puts "/n/n/n/n/nFACEBOOK/n/n/n/n/n"
      for service in services
        if service.provider == service_name
          token = service.token
        end
      end    
      url = "https://api.facebook.com/method/fql.query?"
      url += "&access_token="+ token
      url += "&format=json"
      url += "&query=select src,created,pid from photo where aid in (SELECT aid FROM album WHERE owner IN (SELECT uid2 FROM friend WHERE uid1 = me())) " 
      if (after != nil)
        url += " and created < " + after.to_s
      end
      url += " order by created desc limit 25"
       
      puts url
      resp = RestClient.get(URI.escape(url),{})
      puts resp
      
      
      jsonObj = JSON.parse(resp.body)
      list = []
      for jp in  jsonObj
        p = ExternalPhoto.new
        p.id = jp['pid']
        p.provider = 'facebook'
        p.photo_url = jp['src']
        p.created = jp['created']
        list << p
      end
    else
      list = []
    end
    list
  end

  def connected_to?(provider)
    services.detect{|t| t.provider == provider.to_s} != nil
  end

  def display_name
   if email.length < 1
     email = nil
   end
   return name || twitter_screen_name || email || "test"
  end

  def following?(user)
    followers.include? user
  end

  def followed_by?(user)
      user.followers.include? self 
   
  end
  
  private

  def twitter_client
    client = TwitterOAuth::Client.new(
            :consumer_key => ::TWITTER_CONSUMER_KEY,
            :consumer_secret => ::TWITTER_SECRET_KEY,
            :token => services.twitter.token,
            :secret => services.twitter.secret
    )
  end

  def truncated_message_with_url(message="", url="", length=140)
    if message.size + url.size > 140
      share = message[0..(136-url.size)] + "..." + url
    else
      share = message + " " + url
    end
    share
  end
  
  def servicesempty?
    (services.count == 0)
  end
  
  
  
    def default_values
      self.verified ||= false
      self.twitter_cross_post ||= false
    end
end

