class Sitemap
  
  @@photoBucketCount = 20000

  def self.generateSitemap(args)
    total = Post.count()
    addresses=[]
    AWS::S3::Base.establish_connection!(:access_key_id => 'AKIAIIZEL3OLHCBIZBBQ', :secret_access_key => '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')
    for i in 0..total/@@photoBucketCount
      addr = 'sitemap_partial_'+i.to_s+'.xml'
      addresses << addr
     if args[:all] == 'true' || i == total/@@photoBucketCount
        freq = (i == total/@@photoBucketCount)?"hourly":"monthly"
        AWS::S3::S3Object.store("/sitemap/"+addr, partial_sitemap_xml(Post.find(:all,:conditions => ['twitter_screen_name is NOT NULL'], :limit => @@photoBucketCount, :offset => args[:offset]),freq), 'com.clixtr.picbounce', {:access => :public_read})
     end
    end
    AWS::S3::S3Object.store("/sitemap/sitemap_index.xml", sitemap_index_xml(addresses), 'com.clixtr.picbounce', {:access => :public_read})
  end
  
  def self.partial_sitemap_xml(photos,freq)
    xml = Builder::XmlMarkup.new
    xml.urlset do   
      for photo in photos
        if photo 
          xml.url do
            xml.loc("http:/www.picbounce.com/" + photo.code)
            xml.changefreq freq
            xml.tag!('image:image') do
            xml.tag!('image:loc',photo.post_url(:big))
            xml.tag!('image:caption',photo.text)
          end #do
        end #if
       end #for
      end #do
    end #do
  end
  
  def self.sitemap_index_xml(addresses)
    xml = Builder::XmlMarkup.new
      xml.sitemapindex do   
      for addr in addresses
        xml.sitemap do
          xml.loc("http://s3.amazonaws.com/com.clixtr.picbounce/sitemap/"+addr)
          xml.changefreq "daily"
       end
      end
    end
 end

end
