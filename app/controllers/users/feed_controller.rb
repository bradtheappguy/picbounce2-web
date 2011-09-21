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
  
  def external
    @user = current_user
   
    @photo = Photo.new
    render :status => 404 if @user.nil?

    photos = []
    
    if params[:service_id] == nil
      photos=@user.photos
    else
      photos=@user.external_photos(params[:service_id],params[:after])
    end
  
    respond_to do |format|
      
      
      
      format.html
      format.json {
        response = Responce.new
        response.url = request.fullpath
        response.user = @user
        #if params[:after]
        #  x.photos = user.photos_after params[:user_id]
        #else
          response.photos = photos
        #end
        render_for_api :profile, :json => response 
      }
    end
  end
end
