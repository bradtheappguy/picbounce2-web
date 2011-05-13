class Users::PicbounceCallbackController < ApplicationController
  def picbounce_callback
    puts "redirecting to current user"
    redirect_to profile_url :id => current_user.id
  end
  
 #def apply_facebook_sso
 #   puts "redirecting to /"
 #   redirect_to '/', :params => nil
 # end
  
  
end
