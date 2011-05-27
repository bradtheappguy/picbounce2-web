class Users::FeedController < ApplicationController
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug(params[:id])
    end
    if @user.nil?
      @user = User.find_by_id(params[:id])
    end 
    if @user.nil?
     render :status => 404
    end

    respond_to do |format|
      format.html
      format.json {
        render_for_api :feed, :json => Responce.new(:url => request.url, :photos => @user.feed)
      }
    end
  end
end
