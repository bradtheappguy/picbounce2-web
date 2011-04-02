namespace :utils do
  desc "Fill In Missing Device Ids using facebook and twitter info"
  task :fill_missing_device_ids => :environment do
     puts "Checking for missing Device ids"
     photos_missing_ids = Photo.find(:all, :conditions => ["device_id IS NULL"])
     puts "Found #{photos_missing_ids.count} with missing device ids"
     photos_missing_ids.each {|photo| 
       puts "checking for photo #{photo.id} fb:#{photo.facebook_user_id} tw:#{photo.twitter_screen_name}"
       photo_with_device_id = Photo.find(:last, :conditions => ["(device_id IS NOT NULL) AND (twitter_screen_name = ? OR facebook_user_id = ?)",photo.twitter_screen_name, photo.facebook_user_id])
       if photo_with_device_id
         puts "Found device_id #{photo_with_device_id.device_id}"
         photo.device_id = photo_with_device_id.device_id
         photo.save
       else
         puts "Not Found"
         if photo.facebook_user_id
           photo.device_id = "??fb-#{photo.facebook_user_id}"
           puts "#{photo.id} #{photo.device_id}"
           photo.save
         else
           if photo.twitter_screen_name
             photo.device_id = "??tw-#{photo.twitter_screen_name}"
             puts photo.device_id
             photo.save
           end
         end
       end
     }
  end
  
  desc "load missing twitter avatars into db"
  task :load_twitter_avatars => :environment do 
   Photo.find(:all, :conditions => ['twitter_avatar_url is null and twitter_screen_name is not null']).each do |photo|
      puts "fetching avatar for #{photo.twitter_screen_name} id: #{photo.id}"
      photo.twitter_avatar_url
      puts "... Found: #{photo.twitter_avatar_url}  Updating all records for user"
      Photo.find_all_by_twitter_screen_name(photo.twitter_screen_name).each do |next2|
        next2.twitter_avatar_url = photo.twitter_avatar_url;
        next2.save
      end
   end
  end


  desc "Run Retention Report"
  task :retention_report => :environment do
  
    "1-10-2010".to_date.upto("1-10-2010".to_date) do |day|
      start_day = day
      end_day = day+6
      sql = "select device_id, min(created_at), max(created_at), count(device_id) as foo from photos group by device_id"
      puts sql
      device_ids = Photo.find_by_sql(sql)
     
      device_ids.each {|x|
        puts x.foo
      }
    end

  end

end
