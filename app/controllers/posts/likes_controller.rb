class Posts::LikesController < ApplicationController

  def create
    render :status => 401 if current_user.nil?
    
    @post = Post.find_by_uuid(params[:photo_id])
    @post = Post.find(params[:photo_id]) if @post.nil?
    raise FourOhFour if @post.nil?
    
    if Like.find_or_create_by_photo_id_and_user_id(@post.id, current_user.id)
      render :status => 201, :nothing => true
    else
      render :status => 500, :nothing => true
    end
  end

  def destroy
    render :status => 401, :nothing => true if current_user.nil?
    
    @post = Post.find_by_uuid(params[:photo_id])
    @post = Post.find(params[:photo_id]) if @post.nil?
    raise FourOhFour if @post.nil?
     
    @like = Like.find_by_photo_id_and_user_id(@post.id, current_user.id)
    raise FourOhFour if @like.nil?

    @like.destroy

    render :status => 204, :nothing => true 
  end

end
