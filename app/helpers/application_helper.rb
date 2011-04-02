# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

def title(page_title)
  content_for(:title) { page_title }
end



def twitter_auto_link(text)
  text = auto_link(text)
  # autolink @ tags reference people in Tweets
  text.gsub!(/(^|\s)(@)(\w+)/, '\1<a href="http://twitter.com/\3">\2\3</a>')
  # autolink hash tags
  text.gsub(/(^|\s)(#)(\w+)/, '\1<a href="http://search.twitter.com/search?q=%23\3">\2\3</a>')    
end

end
