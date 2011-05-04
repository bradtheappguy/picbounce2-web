class ProfilesController < ApplicationController
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug(params[:id])
    end
    if @user.nil?
      redirect_to '/'
    end    
  end
end
