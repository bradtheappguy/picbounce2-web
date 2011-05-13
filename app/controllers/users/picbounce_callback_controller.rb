class Users::PicbounceCallbackController < ApplicationController
  def picbounce_callback
    puts "redirecting to current user"
    #redirect_to profile_url :id => current_user.id
    redirect_to current_user
  end
  
 #def apply_facebook_sso
 #   puts "redirecting to /"
 #   redirect_to '/', :params => nil
 # end
  
  
end
