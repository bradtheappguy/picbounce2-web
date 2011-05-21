class UsersController < ApplicationController
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
        x = Responce.new
        x.url = request.fullpath
        x.user = User.find_by_twitter_screen_name(params[:user_id])
        if params[:after]
          x.photos = user.photos_after params[:user_id]
        else
          x.photos = x.user.photos
        end
        render_for_api :profile, :json => x 
      }
    end
  end
end
