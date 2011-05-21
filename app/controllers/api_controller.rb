class ApiController < ApplicationController

  def popular
    if params['twitter']
      @photos = Photo.find_all_by_twitter_screen_name(params['twitter'])
    else
      render_for_api :feed, :json => Photo.find_popular
    end
    #render :text => @photos.to_json
  end

  def profile
    user =  User.find_by_twitter_screen_name(params[:user_id]) 
    if (!user)
      user = User.new(:twitter_screen_name => params[:user_id])
      user.photos << Photo.find_all_by_twitter_screen_name(params[:user_id])
      user.save
    end

      x = Responce.new
      x.url = request.fullpath
      x.user = User.find_by_twitter_screen_name(params[:user_id])
      if params[:after]
        x.photos = user.photos_after params[:user_id]
      else
        x.photos = x.user.photos
      end
      render_for_api :profile, :json => x

    #render_for_api :profile, :json => User.find_by_twitter_screen_name(params[:user_id])
  end 
  
  def nearby
     @photos = Photo.find_all_by_twitter_screen_name('bradsmithinc')
     render :text => @photos.to_json
  end

  def latest
     @photos = Photo.find(:all, :limit => 10)
     render :text => @photos.to_json
  end

  def mentions
     @photos = Photo.find_all_by_twitter_screen_name('b2test')
     render :text => @photos.to_json
  end


  def followers
    user = User.find_by_twitter_screen_name(params[:user_id])
    responce = Responce.new
    responce.url = request.fullpath
    responce.people = user.followers
    render_for_api :followers, :json => responce
  end

  def following
    user = User.find_by_twitter_screen_name(params[:user_id])
    responce = Responce.new
    responce.url = request.fullpath
    responce.people = user.followeds
    render_for_api :followeds, :json => responce
  end

  def create_following
    user = User.find_by_twitter_screen_name(params[:user_id])
    user2 = User.find_by_twitter_screen_name(params[:user])
    user.following << user2
    render :text => 'ok'
  end


end
