class AddFacebookUserIdToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :facebook_user_id, :string
    
#Note this may be too solow for heroku in production
#    Photo.all.each {|photo| 
#      if photo.facebook_access_token
#        a = photo.facebook_access_token.split('-')[1]
#        if a
#          b = a.split('|')[0]
#          photo.facebook_user_id = b if b
#          puts "updating photo #{photo.id}"
#          photo.save
#        end
#      end
#    }

  end

  def self.down
    remove_column :photos, :facebook_user_id
  end
end
