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

  def connected_providers_for(user)
      user.user_tokens.collect{|u| u.provider.to_sym }
        end

          def unconnected_providers_for(user)
              User.omniauth_providers - user.user_tokens.collect{|u| u.provider.to_sym }
                end

                  def notice_html
                      "<div class=\"notice\">#{notice}</div>" unless notice.blank?
                        end

                          def alert_html
                              "<div class=\"alert\">#{alert}</div>" unless alert.blank?
                                end

end
