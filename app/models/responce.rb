class Responce < ActiveRecord::Base
  acts_as_api

  attr_accessor :url
  attr_accessor :user
  attr_accessor :photos
  attr_accessor :people

  class_inheritable_accessor :columns
  
  self.columns = []
     
  def self.column(name, sql_type = nil, default = nil, null = true)
    columns << ActiveRecord::ConnectionAdapters::Column.new(name.to_s, default, sql_type.to_s, null)
  end


  api_accessible :profile do |template|  
    template.add :next
    template.add :user
    template.add :photos
  end

  api_accessible :feed do |template|
    template.add :url
    template.add :photos
    template.add :next
  end

  api_accessible :followers do |template|
    template.add :url
    template.add :people
  end

  api_accessible :followeds do |template|
   template.add :url
   template.add :people
  end


  def next
    if self.photos.last
      timestamp = self.photos.last.created
    end
    nextURL =  self.url.gsub(/[?&]after=\d+/,"")
    if (nextURL.include?('?') == false)
      nextURL = nextURL + "?after=#{timestamp}"
    else
      nextURL = nextURL + "&after=#{timestamp}"
    end
    nextURL
  end


end
