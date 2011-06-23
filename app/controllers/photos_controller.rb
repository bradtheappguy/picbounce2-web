#TODO i[p address loggging

class PhotosController < ApplicationController
  
  before_filter :authorize, :only => :edit
  before_filter :current_user

  layout :choose_layout
  
  
  def edit
    puts "inside edit method"
    @photo = Photo.find_by_code(params[:id])
    @photo.block = 1 if params[:status] == 'Block'
    @photo.block = nil if params[:status] == 'ok'
    @photo.save
    
    redirect_to "/#{params[:id]}"
  end
  
  #This is used for the facebok fan page to show the most recent photos
  #TODO limit this to < 25 to prevent data leakage
  def recent
    @photo = Photo.find(:all, :limit => 1, :offset => params[:id].to_i,  :order => 'id DESC', :conditions => 'block is NULL AND twitter_screen_name IS NOT NULL')[0]
    redirect_to @photo.photo_url(:thumb)
  end
  
  
  def create
     code = rand(1000 * 1000 * 10).to_s(36)
    while Photo.find_by_code(code) 
      code = rand(1000 * 1000 * 10).to_s(36)
    end  

    
    @photo = Photo.create({:photo => params[:photo], 
                          :code => code,
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
                          :filter_name => params[:filter_name]
    })
    @photo.save #TODO is this save necessacarry?
    logger.debug @photo.code
    render 'json_status', :status => @photo.general_status
  end
  
  
  def destroy
    @photo = Photo.find_by_code(params[:id])
    
    if !@photo
      @photo = Photo.find_deleted_by_code(params[:id])
    else
      @photo.deleted = true 
      @photo.facebook_access_token = (params[:facebook_access_token]?(params[:facebook_access_token].split('&')[0]):nil)  #this split is there to fix a big in iPhone Client version 1.2
      
    end
    @photo.save
    render 'json_status',:status => @photo.general_status
  end
  
  
  
  # This is used to post directly from the Tweetie iPhone App
  def tweetie
    code = rand(1000 * 1000 * 10).to_s(36)
    @photo = Photo.create({ :photo => params[:media],
                           :code => code,
	                         :twitter_screen_name => "Picbounce",
	                         :caption => params[:message]
    })
    render :text => "<mediaurl>http://picbounce.com/#{code}</mediaurl>"
  end
  
  #TODO timezone support
  def view
    @photo = Photo.find_by_code(params[:id]) 
    if @photo
      #log this view to our view logging table
      #log = ViewLog.new
      #log.code = params[:id]
      #log.user_agent = request.user_agent
      #log.ip_address = request.env['HTTP_X_REAL_IP']
      #log.save
      
      #@page_title = "Picbounce | #{@photo.caption} - Uploaded by @#{@photo.user.twitter_screen_name}" 
      @photo.view_count = (@photo.view_count || 0) + 1
      @photo.save
     
      screen_name = @photo.user.twitter_screen_name if @photo.user
      if screen_name
        #@next_photo = 
        #@previous_photo = 
      end
      @twitter_screen_name = @photo.user.twitter_screen_name || "" if @photo.user
      local_timestamp = @photo.created_at.in_time_zone("Pacific Time (US & Canada)")
      @time = local_timestamp.strftime("%I:%M %p")
      @timezone = "(PST)"
      @date = local_timestamp.strftime("%A %b %e, %Y")
      @popular_photos = Photo.find_popular
      if mobile_user_agent?
        render :template => 'photos/view-mobile.html.erb', :layout => false
      else
        render :template => 'photos/view.html.erb', :layout => true
      end
    else
      redirect_to "/"
    end
  end
  
  def index
    @hide_download_button = true
    @recent_photos = Photo.recent
    if mobile_user_agent?
      render :template => 'photos/index-mobile.html.erb', :layout => false
    else
      render :template => 'photos/index.html.erb', :layout => true
    end
  end
  
  
  private 
  def choose_layout    
    if [ 'create', 'destroy' ].include? action_name
      nil
    else
      'application'
    end
  end
  
end
