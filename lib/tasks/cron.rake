desc "This task is called by the Heroku cron add-on"
task :cron => :environment do

if Time.now.hour % 1 == 0 # run every 1 hours
    puts "Running Hourly Cron..."
    Rake::Task['sitemap:generate'].execute
    puts "done."
  end
  
  if Time.now.hour == 0 # run at midnight
    puts "Running Midnight Cron..."
    #do stuff
    puts "done."
   end

end
