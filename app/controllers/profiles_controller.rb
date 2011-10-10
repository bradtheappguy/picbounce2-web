class ProfilesController < ApplicationController

  
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug_or_id(params[:id])
    end
    raise FourOhFour if @user.nil?
      
     @photo = Photo.new
     @photos = @user.photos
     
    respond_to do |format|
      format.html
      format.json { render_api_response :user => @user, :photos => @photos }
    end
  end  
  
end
