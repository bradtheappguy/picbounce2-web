class Users::FollowersController < ApplicationController

  def index
    @user = User.find_by_id(params[:id])
    @followers = @user.followers
  end

end
