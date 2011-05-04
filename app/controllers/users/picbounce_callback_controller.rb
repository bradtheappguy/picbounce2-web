class Users::PicbounceCallbackController < ApplicationController
  def picbounce_callback
    redirect_to '/', :params => nil
  end
end
