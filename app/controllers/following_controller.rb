class FollowingController < ApplicationController
  def create
    user_namr = params[:user_id]
    user_name = 'bradsmithinc' if user_name == 'me' 
    user = User.find_by_twitter_screen_name(user_name)
    user.followers << User.find_by_id(params[:id])
    render :text => '1'
  end

  def destroy
  end

end
