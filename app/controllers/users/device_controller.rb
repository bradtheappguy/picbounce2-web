class Users::DeviceController < ApplicationController
  before_filter :authenticate_user!

  def create
    current_user.devices << APN::Device.find_or_create_by_token(params[:apns_token])
    if current_user.save
      render :nothing => true, :status => 201
    else
      render :nothing => true, :status => 401
    end
  end
end
