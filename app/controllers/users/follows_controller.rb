class Users::FollowsController < ApplicationController

  def index
    @user = User.find_by_slug_or_id(params[:id])
    @follows = @user.followeds
    respond_to do |format|
      format.html
      format.json {
        render_api_response :people => @follows
      }
    end
  end

end
