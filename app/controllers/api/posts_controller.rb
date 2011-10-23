class Api::PostsController < ApplicationController
  before_filter :authenticate_user!, :except => [:user,:user_feed,:user_posts,:post,:post_comments]
  
  #GET
  def show
    @post = Post.find_by_code(params[:id]) 
    render '/api/post'
  end
  
   def comments
    @comments = Post.find_by_code(params[:id]).comments 
    render '/api/list'
  end
  
   
   
   
  #POST
  def create
    code = rand(1000 * 1000 * 10).to_s(36)
    while Post.find_by_code(code) 
      code = rand(1000 * 1000 * 10).to_s(36)
    end  
    @post = Post.create({:photo => params[:photo],
                          :key => params[:key],
                          :code => code,
                          :ptype => params[:ptype],
                          :twitter_oauth_token =>  params[:twitter_oauth_token],
                          :twitter_oauth_secret => params[:twitter_oauth_secret],
                          :facebook_access_token => (params[:facebook_access_token]?(params[:facebook_access_token].split('&')[0]):nil),  #this split is there to fix a big in iPhone Client version 1.2
                          :caption => params[:caption],
                          :user_agent => request.user_agent,
                          :device_type => params[:system_model],
                          :os_version =>  params[:system_version],
                          :device_id => params[:device_id],
                          :ip_address => request.env['HTTP_X_REAL_IP'],
                          :filter_version => params[:filter_version],
                          :filter_name => params[:filter_name],
                          :user => current_user
    })
    @post.save 
    render 'api/post'
  end
  
  def create_comment
    @comment = Comment.new
    @comment.text = params[:caption]
    @comment.user = current_user
    post = Post.find_by_code(params[:id])
    post.comments << @comment
    render 'api/comment'
  end
  
  def create_flag
    render :status => 401 if current_user.nil?
    
    @post = Post.find_by_code(params[:id]) if @post.nil?
    raise FourOhFour if @post.nil?
    
    if Flag.find_or_create_by_post_id_and_user_id(@post.id, current_user.id)
      render 'api/post'
    else
      render :status => 500, :nothing => true
    end
  end
  
  
  
  
  
  
  
  #DELETE 
  def destroy
    @post = Post.find_by_code(params[:id])
    @post.twitter_oauth_token = params[:twitter_oauth_token]
    @post.twitter_oauth_secret = params[:twitter_oauth_secret]
    
    if @post
      @post = Post.find_deleted_by_code(params[:id])
    else
      @post.deleted = true 
      @post.facebook_access_token = (params[:facebook_access_token]?(params[:facebook_access_token].split('&')[0]):nil)  #this split is there to fix a big in iPhone Client version 1.2
      
    end
    @post.save
    render 'api/post'
  end
  
  def destroy_flag
     render :status => 401, :nothing => true if current_user.nil?
    
    @post = Post.find_by_code(params[:id])
    raise FourOhFour if @post.nil?
     
    @like = Flag.find_by_post_id_and_user_id(@post.id, current_user.id)
    raise FourOhFour if @like.nil?

    @like.destroy

    render :status => 204, :nothing => true 
  end
  
end
