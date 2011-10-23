class Api::UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:user,:user_feed,:user_posts,:post,:post_comments]
  
  #GET
  def show
    @user = User.find_by_twitter_screen_name(params[:id]) 
    render '/api/user'
  end
  
  def feed
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
  
  
  
  def posts
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
  
 
  
  
  
  
  #POST
  def edit
    @user = User.first
    render 'api/user'
  end
  
  
  def create_follower
    user = User.find_by_twitter_screen_name(params[:id])
    user.followers << current_user
    render 'api/user'
  end
  
  
  
  
  
  #DELETE
  def destroy_follower
    @user = User.find_by_twitter_screen_name(params[:id])
    @user.followers.delete(current_user)
    render 'api/user'
  end
  
  
  
  
end
