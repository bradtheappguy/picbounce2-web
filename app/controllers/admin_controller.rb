
require 'httpclient'
class AdminController < ApplicationController
  before_filter :authenticate_user!, :except => :sitemap_partial
  
  layout nil
  
  def index
  end

end
