require 'rubygems'
require 'mechanize'
require 'logger'

agent = Mechanize.new
agent.log = Logger.new(STDOUT)
agent.follow_meta_refresh = true
agent.redirect_ok = true
puts agent
pp agent.get "http://graph.facebook.com/oauth/authorize?client_id=125208417509976&redirect_uri=http://www.picbounce.com/oauth_redirect&display=wap"

puts "-------------------"
pp agent.page.title
puts "--------------------"
login_form = agent.page.forms[0]
login_form.email = "bradsmithinc@gmail.com"
login_form.pass = "bathe4fb"
page = agent.submit(login_form)

##pp page
##pp page.title
##pp page.forms

pp "QQQQQQQQQQQQQQQQ"

#page = agent.get page.search("//meta").first.attributes['href'].gsub(/'/,'')

pp page
pp agent.history.count
pp "WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW"
pp agent.history[1]

