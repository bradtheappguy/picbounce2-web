class Users::FeedController < ApplicationController
  def show
    render 'home/splash' unless current_user
  end
  
end
