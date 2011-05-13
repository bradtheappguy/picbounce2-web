# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include RedirectBack
  
  helper_method :resource_class
  protect_from_forgery

  def current_user
    super || NilUser.new
  end

  def user_signed_in?
    !current_user.nil?
  end


  before_filter :configure_split_group
  
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  def appstore
    redirect_to 'http://click.linksynergy.com/fs-bin/stat?id=AMGhxDPIbSM&offerid=146261&type=3&subid=0&tmpid=1826&RD_PARM1=http%253A%252F%252Fitunes.apple.com%252Fus%252Fapp%252Fpicbounce%252Fid378022697%253Fmt%253D8%2526uo%253D4%2526partnerId%253D30'
  end

  def sitemap 

    url = URI.parse('http://s3.amazonaws.com/com.clixtr.picbounce/sitemap/sitemap_index.xml')
    res = Net::HTTP.start(url.host, url.port) {|http|
          http.get('/com.clixtr.picbounce/sitemap/sitemap_index.xml')
    }
   render :text => res.body
  end
  def fb_post_authorize 
    render :text => ''
  end


  def configure_split_group
    @use_echo_comments = true
    @use_disqus_comments = false
    
    if params['a'] == '1'
      @use_echo_comments = true
      @use_disqus_comments = false
    end

    if params['a'] == '2'
      @use_echo_comments = false
      @use_disqus_comments = true
    end
  end
  
    
  def download
  end


  def mobile_user_agent?
    #this currently only detects mobile Safari.  We will need to add support for other mobile browsers
    if request.env["HTTP_USER_AGENT"] 
      agent = request.env["HTTP_USER_AGENT"]
      return true if agent.include? "CFNetwork"
      return true if agent.include? "iPhone"
      return true if agent.include? "Android"
      return true if agent.include? "Android" 
    end
  false 
  end

 
  helper_method :admin?

  protected

  #def current_user
  #  current_user = User.find_by_twitter_oauth_token(params[:twitter_oauth_token]) if params[:twitter_oauth_token] || User.new
  #  current_user.update_attributes({ 
  #    :twitter_oauth_token =>  params[:twitter_oauth_token],
  #    :twitter_oauth_secret => params[:twitter_oauth_secret],
  #    :facebook_access_token => params[:facebook_access_token],
  #  }) if current_user
  #end

  def authorize
    unless admin?
    flash[:message] = 'Unautorized Access Attempt'
      redirect_to '/login'
    end
  end


  #Note: the test@clixtr user is here for our functional testing
  def admin?
   return false unless session[:password]
   if ((session[:username] == "brad@clixtr.com") && (Digest::MD5.hexdigest(session[:password]) == "4e0ca2034165058aa53acbdbf17ce753"))   ||
      ((session[:username] == "fergus@clixtr.com") && (Digest::MD5.hexdigest(session[:password]) == "fe96def4233f8482d693435e45a4f210")) || 
      ((session[:username] == "max@clixtr.com") && (Digest::MD5.hexdigest(session[:password]) == "2256eebfa7071492dbb408548b4bf12b"))    ||
      ((session[:username] == "test@clixtr.com") && (Digest::MD5.hexdigest(session[:password]) == "de50205b76023be05c747d7e8dcf95c7"))
   return true 
   else
     logger.info "#{session[:username]} #{session[:password]} #{Digest::MD5.hexdigest(session[:password])} NO GOOD"
     return false
   end 

   end



end
