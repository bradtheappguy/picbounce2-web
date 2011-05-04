class User < ActiveRecord::Base
  include OmniAuthPopulator
  include Sluggable

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable, :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  acts_as_api

  has_many :authentications

  has_many :photos, :limit => 10, :order => 'created_at desc'
  has_many :all_photos, :class_name => 'Photo'

#Followers
  #Joins:
  has_many :followings 
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follower_id"
 

  has_many :followers,  :through => :followings       
  has_many :followeds,  :through => :inverse_followings, :source => :user

#JSON TEmplates
  api_accessible :base do |template|
   template.add :name
   template.add :twitter_screen_name
   template.add :twitter_avatar_url
  end

  api_accessible :feed, :extend => :base do |template|
  end

  api_accessible :profile, :extend => :base do |template|
    template.add :last_location
    template.add :followers_count
    template.add :followers_url
    template.add :following_count
    template.add :following_url
    template.add :badges_count
    template.add :photo_count 
  end

  api_accessible :followeds, :extend => :base do |template|
  end

  api_accessible :followers, :extend => :base do |template|
  end


  def followers_url
    "http://localhost:3000/api/users/b2test/followers"
  end

  def following_url
    "http://localhost:3000/api/users/b2test/following"
  end
   

  def photo_count
    self.all_photos.count
  end

   def followers_count
    66
  end

  def following_count
    77
  end

  def badges_count
    88
  end

  def last_location
    "San Francsico"
  end

  def photos_after(timestamp)
    Photo.find(:all, :conditions => ["user_id = ? and created_at < ?", self.id, Time.at(timestamp.to_i) ], :order => 'created_at asc', :limit => 10)
  end

  attr_accessible :email, :password, :password_confirmation, :remember_me
  
  def apply_omniauth(omniauth)
    self.email = omniauth['user_info']['email'] if email.blank?
    authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'])
  end
      
  def photo
  end

  def photo=(i)
  end

  def password_required?
    false
    #(authentications.empty? || !password.blank?) && super
  end



 before_validation :generate_slug, :on => :create
  
  validates_uniqueness_of :slug
  validates_length_of :slug, :minimum => 1

  has_many :user_tokens do
    def facebook
      target.detect{|t| t.provider == 'facebook'}
    end

    def twitter
      target.detect{|t| t.provider == 'twitter'}
    end
  end

  has_many :sharings

 # has_attached_file :photo,
 #                   :styles => {
 #                           :mini => "40x40#",
 #                           :thumb => "80x80#",
 #                           :small => "100x100#",
 #                           :big => "150x150#"
 #                   },
 #                   :default_url => "/images/user_photos/missing_:style.png"

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable, :lockable and :timeoutable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :omniauthable, :validatable #:flexible_devise_validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :slug

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session[:omniauth]
        user.user_tokens.build(:provider => data['provider'], :uid => data['uid'])
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
    slug
  end

  def apply_omniauth(omniauth)
    self.omniauth = omniauth
    user_tokens.build(:provider => omniauth['provider'], :uid => omniauth['uid'], :omniauth => omniauth)

    #populate_photo_from_url(omniauth['user_info']['image']) unless photo.exists? || omniauth['user_info']['image'].blank?
  end

  def populate_from_twitter(omni)
    self.name = omni['user_info']['name'] if self.name.blank?
  end

  def populate_from_google_apps(omni)
    self.name = omni['user_info']['name'] if self.name.blank?
  end

  def populate_from_facebook(omni)
    self.name = omni['user_info']['name'] if self.name.blank?
    self.email = omni['user_info']['email'] if self.email.blank?
  end

#allows for account creation from twitter & fb
#allows saves w/o password
  def password_required?
    (!persisted? && user_tokens.empty?) || password.present? || password_confirmation.present?
  end

#allows for account creation from twitter
  def email_required?
    user_tokens.empty?
  end

  def remember_me
    super.nil? ? false : true
  end

  def tweet!(message, url=DEFAULT_SHARE_URL)
    twitter_client.update truncated_message_with_url(message, url)
  end

  def fb_post!(message, name=DEFAULT_FB_POST_NAME,
          description="TODO", url=DEFAULT_SHARE_URL, img=DEFAULT_FB_SHARE_IMAGE)
    options = {'access_token' => user_tokens.facebook.token,
               'message' => message,
               'link' => url,
               'picture' => img,
               'name' => name,
               'caption' => url,
               'description' => description
    }
    RestClient.post(URI.escape("https://graph.facebook.com/me/feed/"), options)
  end

  def connected_to?(provider)
    user_tokens.detect{|t| t.provider == provider.to_s} != nil
  end

  def display_name
    name || email
  end

  private

  def populate_photo_from_url(image_url)
    require 'open-uri'
    io = open(URI.parse(image_url))

    def io.original_filename;
      base_uri.path.split('/').last;
    end

    self.photo = io.original_filename.blank? ? nil : io
    #todo for now throw, not sire the error cases
  end

  def twitter_client
    client = TwitterOAuth::Client.new(
            :consumer_key => ::TWITTER_CONSUMER_KEY,
            :consumer_secret => ::TWITTER_SECRET_KEY,
            :token => user_tokens.twitter.token,
            :secret => user_tokens.twitter.secret
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
end

