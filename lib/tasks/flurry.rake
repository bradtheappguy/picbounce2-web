namespace :flurry do
  desc "Import data from flurry"
  task :import => :environment do
     puts "Importing Flurry Data"
     FlurryRecord.import
  end
end
