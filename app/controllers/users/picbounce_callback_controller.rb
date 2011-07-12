class Users::PicbounceCallbackController < ApplicationController
  def picbounce_callback
    puts "redirecting to /"
    redirect_to '/', :params => nil
  end
  
 #def apply_facebook_sso
 #   puts "redirecting to /"
 #   redirect_to '/', :params => nil
 # end
  
  
end
