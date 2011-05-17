class FollowingsController < ApplicationController
  
  def create
    user = User.find_by_id(params[:user_id])
    user.followers << current_user
    redirect_to :back
  end

  def destroy
    user = User.find_by_id(params[:user_id])
    current_user.followeds.delete(user)
    redirect_to :back
  end
  
end
