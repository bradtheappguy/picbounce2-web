class UsersController < ApplicationController
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug(params[:id])
    end
   
    @user = User.find_by_id(params[:id]) if @user.nil? 
    
    
    @photo = Photo.new
    render :status => 404 if @user.nil?

    
    respond_to do |format|
      format.html
      format.json {
        response = Responce.new
        response.url = request.fullpath
        response.user = @user
        #if params[:after]
        #  x.photos = user.photos_after params[:user_id]
        #else
          response.photos = @user.photos
        #end
        render_for_api :profile, :json => response 
      }
    end
  end
end
