class Photos::LikesController < ApplicationController

  def create
    render :status => 401 if current_user.nil?
    
    @photo = Photo.find_by_uuid(params[:photo_id])
    @photo = Photo.find(params[:photo_id]) if @photo.nil?
    raise FourOhFour if @photo.nil?
    
    if Like.find_or_create_by_photo_id_and_user_id(@photo.id, current_user.id)
      render :status => 201, :nothing => true
    else
      render :status => 500, :nothing => true
    end
  end

  def destroy
    render :status => 401, :nothing => true if current_user.nil?
    
    @photo = Photo.find_by_uuid(params[:photo_id])
    @photo = Photo.find(params[:photo_id]) if @photo.nil?
    raise FourOhFour if @photo.nil?
     
    @like = Like.find_by_photo_id_and_user_id(@photo.id, current_user.id)
    raise FourOhFour if @like.nil?

    @like.destroy

    render :status => 204, :nothing => true 
  end

end
