#TODO i[p address loggging

class PostsController < ApplicationController
  
  before_filter :authorize, :only => {:edit, :create}
  before_filter :current_user
  
  layout :choose_layout

  #TODO timezone support
  def show
    @photo = Post.find_by_code(params[:id]) 
    @photo.view_count = (@photo.view_count || 0) + 1
    @photo.save
  end  
  
  
  #This is used for the facebok fan page to show the most recent photos
  #TODO limit this to < 25 to prevent data leakage
  def recent
    @photo = Post.find(:all, :limit => 1, :offset => params[:id].to_i,  :order => 'id DESC', :conditions => 'block is NULL AND twitter_screen_name IS NOT NULL')[0]
    redirect_to @photo.post_url(:thumb)
  end
  
  
  
  # This is used to post directly from the Tweetie iPhone App
  def tweetie
    code = rand(1000 * 1000 * 10).to_s(36)
    @photo = Post.create({ :photo => params[:media],
                           :code => code,
	                         :twitter_screen_name => "Picbounce",
	                         :text => params[:message]
    })
    render :text => "<mediaurl>http://picbounce.com/#{code}</mediaurl>"
 end
 
  def callback
  end
  
  def choose_layout
   
 
   # or you could do
   case action_name
    when 'callback': nil
    else 'application'
   end
 end
  
end
