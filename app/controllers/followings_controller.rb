class FollowingsController < ApplicationController

  before_filter :authenticate_user!

  def create
    user = User.find_by_id(params[:user_id])
    user.followers << current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :text => 'works' }
    end
    
  end

  def destroy
    user = User.find_by_id(params[:user_id])
    current_user.followeds.delete(user)
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render :text => 'works' }
    end
  end
  
end
