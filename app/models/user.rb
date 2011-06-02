class User < ActiveRecord::Base
  include Sluggable
  
  acts_as_api
  
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :omniauthable, :token_authenticatable, :validatable
  
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :slug
  
  has_many :photos, :limit => 1000, :order => 'created_at desc'
  has_many :all_photos, :class_name => 'Photo'  
  has_many :followings 
  has_many :inverse_followings, :class_name => "Following", :foreign_key => "follower_id"
  has_many :followers,  :through => :followings       
  has_many :followeds,  :through => :inverse_followings, :source => :user
  has_many :user_filters
  has_many :filters,  :through => :user_filters
  
  def feed
    @photos = followeds.find(:all, :include => :photos).collect(&:photos).flatten
  end
  
  has_many :services do
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
    slug || id
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
    (!persisted? && servicesempty?) || password.present? || password_confirmation.present?
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

  def connected_to?(provider)
    services.detect{|t| t.provider == provider.to_s} != nil
  end

  def display_name
    name || email || 'no name'
  end

  def following?(user)
    followers.include? user
  end

  def followed_by?(user)
    user.followers.include? self if user
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
  
end

