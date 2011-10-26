class Api::UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:user,:user_feed,:user_posts,:post,:post_comments]
  
  #GET
  def show
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug_or_id(params[:id])
    end
    
    raise FourOhFour if @user.nil?
    render '/api/response'
  end
  
  def feed
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug_or_id(params[:id])
    end
    raise FourOhFour if @user.nil?
    
    if params[:after]
      @posts = @user.feed
    elsif
      @posts = @user.feed
    else
      @posts = @user.feed
    end
    
    render '/api/response'
  end
  
  
  
  def posts
    limit = 10
    if params[:id] == "me"
      @user = current_user
    else
      @user = User.find_by_slug_or_id(params[:id])
    end
    raise FourOhFour if @user.nil?
    if params[:after]
      after = params[:after].to_f
      @posts = @user.posts_after(after,limit)
    elsif
      params[:before]
      before = params[:before].to_f
      @posts = @user.posts_before(before,limit)
    else
      @posts = @user.posts.limit(limit).all
    end
    render '/api/response'
  end
  
 
  
  
  
  
  #POST
  def edit
    if params[:id] != "me" || params[:id] != current_user.id
      #TODO: error handling
      render :text => '500', :status => 500
    end
    
    @user = current_user
    @user.twitter_avatar_url = params[:avatar] unless !params.key?(:avatar)
    @user.name = params[:name] unless !params.key?(:name)
    @user.fb_crosspost_pages = params[:fb_crosspost_pages] unless !params.key?(:fb_crosspost_pages)
    @user.tw_crosspost = params[:tw_crosspost] unless !params.key?(:tw_crosspost)
    @user.save
    render 'api/response'
  end
  
  
  def create_follower
    #raise if @user = current_user
    
    user = User.find_by_slug_or_id(params[:id])
    user.followers << current_user
    render 'api/response'
  end
  
  
  
  
  
  #DELETE
  def destroy_follower
    #raise if @user = current_user
    
    @user = User.find_by_slug_or_id(params[:id])
    @user.followers.delete(current_user)
    render 'api/response'
  end
  
  
  
  
end
