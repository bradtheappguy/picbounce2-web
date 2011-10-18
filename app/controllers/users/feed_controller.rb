class Users::FeedController < ApplicationController
  def show
    if !user_signed_in?
      @hide_download_button = true
      @recent_photos = Post.recent
      render 'posts/index'
    else
    if params[:id] == nil || params[:id] == "me" 
      @user = current_user
    else
      @user = User.find_by_slug(params[:id])
    end
    if @user.nil?
      @user = User.find_by_id(params[:id])
    end 
    raise FourOhFour if @user.nil?
    
    @photos = @user.feed
    @api_response = Response.new(:url => request.url, :photos => @user.feed, :user => @user)
    
    respond_to do |format|
      format.html
      format.json { render_api_response :photos => @photos }
    end
    end
  end
  
  def external
    @user = current_user
   
    @photo = Post.new
    render :status => 404 if @user.nil?

    photos = []
    
    if params[:service_id] == nil
      photos=@user.posts
    else
      photos=@user.external_photos(params[:service_id],params[:after])
    end
  
    respond_to do |format|

      format.html
      format.json {
        render_api_response :user => @user, :photos => @photos
      }
    end
  end
end
