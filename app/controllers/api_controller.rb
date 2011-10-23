class ApiController < ApplicationController
  
  before_filter :authenticate_user!, :except => [:user,:user_feed,:user_posts,:post,:post_comments]
  
  
  #GET
  def user
    @user = User.find_by_twitter_screen_name(params[:id]) 
    render '/api/user'
  end
  
  def user_feed
    user = User.find_by_twitter_screen_name(params[:id])
    if params[:after]
      @posts = user.feed
    elsif
      @posts = user.feed
    else
      @posts = user.feed
    end
    
    render '/api/list'
  end
  
  def user_posts
    limit = 10
    user = User.find_by_twitter_screen_name(params[:id]) 
    if params[:after]
      after = Time.zone.parse(params[:after])
      @posts = user.posts_after(after,limit)
    elsif
      params[:before]
      before = Time.zone.parse(params[:before])
      @posts = user.posts_before(before,limit)
    else
      @posts = user.posts.limit(limit).all
    end
    
    render '/api/list'
  end
  
 
  def post
    @post = Post.find_by_code(params[:id]) 
    render '/api/post'
  end
  
   def post_comments
    @comments = Post.find_by_code(params[:id]).comments 
    render '/api/list'
  end
  
  #POST
  def edit_user
    @user = User.first
    render 'api/user'
  end
  
  
  def create_user_follower
    user = User.find_by_twitter_screen_name(params[:id])
    user.followers << current_user
    render 'api/user'
  end
  
  def create_post
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
  
  def create_post_comment
    @comment = Comment.new
    @comment.text = params[:caption]
    @comment.user = current_user
    post = Post.find_by_code(params[:id])
    post.comments << @comment
    render 'api/comment'
  end
  
  def create_post_flag
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
  def destroy_user_follower
    @user = User.find_by_twitter_screen_name(params[:id])
    @user.followers.delete(current_user)
    render 'api/user'
  end
  
  def destroy_post
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
  
  def destroy_post_flag
     render :status => 401, :nothing => true if current_user.nil?
    
    @post = Post.find_by_code(params[:id])
    raise FourOhFour if @post.nil?
     
    @like = Flag.find_by_post_id_and_user_id(@post.id, current_user.id)
    raise FourOhFour if @like.nil?

    @like.destroy

    render :status => 204, :nothing => true 
  end
  
  
  
  
  
  
  #old api
  def popular
    @photos = Post.find_popular
    respond_to do |format|
      format.json { render_api_response :photos => @photos }
    end
  end

  def profile
    user =  User.find_by_twitter_screen_name(params[:user_id]) 
    if (!user)
      user = User.new(:twitter_screen_name => params[:user_id])
      user.posts << Post.find_all_by_twitter_screen_name(params[:user_id])
      user.save
    end

      x = Response.new
      x.url = request.fullpath
      x.user = User.find_by_twitter_screen_name(params[:user_id])
      if params[:after]
        x.posts = user.posts_after params[:user_id]
      else
        x.posts = x.user.posts
      end
      render_for_api :profile, :json => x

    #render_for_api :profile, :json => User.find_by_twitter_screen_name(params[:user_id])
  end 
  
  def nearby
     @photos = Post.find_all_by_twitter_screen_name('bradsmithinc')
     render :text => @photos.to_json
  end

  def latest
     @photos = Post.find(:all, :limit => 10)
     render :text => @photos.to_json
  end

  def mentions
     @photos = Post.find_all_by_twitter_screen_name('b2test')
     render :text => @photos.to_json
  end


  def followers
    user = User.find_by_twitter_screen_name(params[:user_id])
    response = Response.new
    response.url = request.fullpath
    response.people = user.followers
    render_for_api :followers, :json => response
  end

  def following
    user = User.find_by_twitter_screen_name(params[:user_id])
    response = Response.new
    response.url = request.fullpath
    response.people = user.followeds
    render_for_api :followeds, :json => response
  end

  def create_following
    user = User.find_by_twitter_screen_name(params[:user_id])
    user2 = User.find_by_twitter_screen_name(params[:user])
    user.following << user2
    render :text => 'ok'
  end
  
  
  
  
  
  
  
  
end
