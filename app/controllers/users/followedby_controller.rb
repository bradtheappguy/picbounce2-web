class Users::FollowedbyController < ApplicationController

  def index
    @user = User.find_by_id(params[:id])
    @followedby = @user.followers
  end

end
