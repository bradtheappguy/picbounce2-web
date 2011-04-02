#TODO merge this with the admin controller ad they are basically the same thing
#Update views and routes accordingly

class SessionsController < ApplicationController

  def create
    session[:password] = params[:password]
    session[:username] = params[:username]
    if admin?
      redirect_to '/admin'
    else
      flash[:message] = 'Login Failed'
      redirect_to '/login'
    end
  end

  def destroy
    reset_session
    flash[:notice] = 'Successfully logged out'
    redirect_to '/login'
  end

  def new
    @service_status = Photo.last.created_at.between?(3.minute.ago, Time.now)
  end

end
