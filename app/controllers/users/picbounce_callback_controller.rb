class Users::PicbounceCallbackController < ApplicationController
  def picbounce_callback
    raise if !current_user
    if !params[:auth_token]
      redirect_to "/users/auth/picbounce?auth_token=#{current_user.authentication_token}&user_id=#{current_user.id}" 
    else
      redirect_to "/users/me"
    end
  end
  
  def user_url
    "http://yahooo.com"
  end
 #def apply_facebook_sso
 #   puts "redirecting to /"
 #   redirect_to '/', :params => nil
 # end
  
  
end
