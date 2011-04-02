class User < ActiveRecord::Base
  acts_as_api

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
end
