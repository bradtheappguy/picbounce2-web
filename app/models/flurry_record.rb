
require 'mechanize'
require 'fastercsv'

class FlurryRecord < ActiveRecord::Base

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
	agent.submit form

        sessions = agent.get "http://dev.flurry.com/sessionsCsv.do?projectID=41251&versionCut=versionsAll&intervalCut=allTime&zoom=d"
	users = agent.get    "http://dev.flurry.com/usersCsv.do?projectID=41251&versionCut=versionsAll&intervalCut=allTime&zoom=d"
        userTenure =  agent.get "http://dev.flurry.com/usersTenureCsv.do?projectID=41251&versionCut=versionsAll&intervalCut=allTime&zoom=d"

        puts users.body
        puts sessions.body
        puts userTenure.body

        FasterCSV.parse(users.body, :headers => :first_row, :write_headers => :false) do |row|          
          date = Date.parse(row[0])    
          instance = FlurryRecord.find_or_create_by_date(Date.parse(row[0]))
          instance.active_users = row[1]
          instance.save
        end   

        FasterCSV.parse(sessions.body, :headers => :first_row, :write_headers => :false) do |row|          
          instance = FlurryRecord.find_or_create_by_date(Date.parse(row[0]))
          instance.sessions = row[1]
          instance.save
        end   

        FasterCSV.parse(userTenure.body, :headers => :first_row, :write_headers => :false) do |row|          
          instance = FlurryRecord.find_or_create_by_date(Date.parse(row[0]))
          instance.new_users = row[1]
          instance.retained_users = row[2]
          instance.save
        end   

  end
end
