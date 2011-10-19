class ApiController < ApplicationController

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

  def feed
    limit = 100
    user = User.find_by_twitter_screen_name(params[:user_id])
    if params[:after]
      after = Time.zone.parse(params[:after])
      @posts = user.posts_after(after,limit)
    elsif
      params[:before]
      before = Time.zone.parse(params[:before])
      @posts = user.posts_before(before,limit)
    else
      @posts = user.posts.limit(limit)
    end
    render :text => @posts.to_json
  end
end
