class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => :edit
  
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug_or_id(params[:id])
    end
    
    raise FourOhFour if @user.nil?
  end  
  
  def edit
    
  end
  
    def omniauth_signout
      if params[:provider] == "twitter"
        raise "Sorry, you can't sign out of twitter"
      end
      if params[:provider] && current_user 
        s = Service.find_by_provider_and_user_id(params[:provider], current_user.id)
        s.delete() unless !s
        if params[:next]
          redirect_to params[:next]
        else
          redirect_to '/'
        end
      end
    end
  
end
