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
  
end
