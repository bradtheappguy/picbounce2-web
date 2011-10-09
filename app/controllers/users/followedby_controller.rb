class Users::FollowedbyController < ApplicationController

  def index
    @user = User.find_by_slug_or_id(params[:id])
    @followedby = @user.followers
    respond_to do |format|
      format.html
      format.json {
        render_api_response :people => @followedby
      }
    end
  end

end
