namespace :sitemap do
  desc "Generate Sitemap"
  task :generate => :environment do
     puts "Generating Entire SiteMap from scratch"
     Sitemap.generateSitemap :all => true
  end
end
