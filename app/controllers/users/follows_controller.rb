class Users::FollowsController < ApplicationController

  def index
    @user = User.find_by_slug_or_id(params[:id])
    @follows = @user.followeds
    respond_to do |format|
      format.html
      format.json {
        render_for_api :follows, :json => Responce.new(:url => request.url, :people => @follows)
      }
    end
  end

end
