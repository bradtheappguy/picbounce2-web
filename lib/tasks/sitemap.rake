namespace :sitemap do
  desc "Import data from flurry"
  task :generate => :environment do
     puts "Generating Entire SiteMap from scratch"
     Sitemap.generateSitemap :all => true
  end
end
