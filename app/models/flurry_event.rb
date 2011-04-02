
require 'mechanize'
require 'fastercsv'

class FlurryEvent < ActiveRecord::Base

  def self.find_or_create_by_date(date) 
    instance = FlurryRecord.find_by_date(date)
    if !instance
      instance = FlurryRecord.new
    end
    instance.date = date
    return instance
  end


  def self.import
	agent = WWW::Mechanize.new
	page = agent.get "https://dev.flurry.com/secure/login.do"
	form = page.forms.first
	form.loginPassword = "poopypants"
	form.loginEmail = "brad@clixtr.com"
	puts agent.submit form

        events = agent.get "http://dev.flurry.com/eventsLogCsv.do?projectID=41251&versionCut=versionsAll&intervalCut=allTime&zoom=d"

        puts events.body

        FasterCSV.parse(events.body, :headers => :first_row, :write_headers => :false) do |row|            
          instance = FlurryEvent.new
          instance.date = row[0]
          instance.session_index = row[1]
          instance.event = row[2]
          instance.description = row[3]
          instance.version = row[4]
          instance.platform = row[5]
          instance.device = row[6]
          instance.user_id = row[7]
          instance.params = row[8]
          instance.save
        end   
  end
end
