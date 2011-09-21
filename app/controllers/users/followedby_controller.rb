class Users::FollowedbyController < ApplicationController

  def index
    @user = User.find_by_slug_or_id(params[:id])
    @followedby = @user.followers
    respond_to do |format|
      format.html
      format.json {
        render_for_api :follows, :json => Responce.new(:url => request.url, :people => @followedby)
      }
    end
  end

end
