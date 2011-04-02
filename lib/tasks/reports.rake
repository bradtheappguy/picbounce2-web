namespace :reports do
  desc "Import data from flurry"
  task :xxx => :environment do
     puts "Running xxx report"
     photos = Photo.find_by_sql('select * from photos  where facebook_user_id is not null group by facebook_user_id;');
     photos.each { |photo| 
       puts "#{photo.facebook_user_id}, #{Photo.find_all_by_facebook_user_id(photo.facebook_user_id).count}"
     }
  end

  desc "Run posting report"
  task :posting => :environment do
    start_date = Date.parse("Sept 27, 2010")
    end_date = 0.day.ago


    puts "Date\tAll_Photos\tFacebook_Photos\tTwitter_Photos"
    
    x = 0

    while (x < 100) 
      all_photos = Photo.count(:conditions => ["created_at >= ? AND created_at <= ?",start_date,start_date+1.day])
      facebook_photos = Photo.count(:conditions => ["facebook_access_token IS NOT NULL AND created_at >= ? AND created_at <= ?",start_date,start_date+1.day])
      twitter_photos = Photo.count(:conditions => ["twitter_screen_name IS NOT NULL AND created_at >= ? AND created_at <= ?",start_date,start_date+1.day])
      puts "#{start_date}\t#{all_photos}\t#{facebook_photos}\t#{twitter_photos}"
      start_date = start_date+1.day
      x = x + 1
    end


  end
end
