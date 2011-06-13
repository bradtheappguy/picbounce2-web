class Users::PicbounceCallbackController < ApplicationController
  def picbounce_callback
    raise if !current_user
    if !params[:auth_token]
      redirect_to "/users/auth/picbounce?auth_token=#{current_user.authentication_token}" 
    else
      redirect_to current_user
    end
  end
  
 #def apply_facebook_sso
 #   puts "redirecting to /"
 #   redirect_to '/', :params => nil
 # end
  
  
end
