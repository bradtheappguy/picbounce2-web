
require 'httpclient'
class AdminController < ApplicationController
  before_filter :authorize,:except => :sitemap_partial
  
  layout nil
  
  def index
  end

end
