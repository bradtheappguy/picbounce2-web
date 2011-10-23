class Users::FeedController < ApplicationController
  def show
    render 'home/splash' unless current_user
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
