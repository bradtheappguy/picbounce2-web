require 'garb'
require 'nokogiri'
require 'mechanize'


class FiltersController < ApplicationController
 
 
 def test2
  f = Filter.find_all_by_release(params[:release])
  
  
    respond_to do |format|
      format.xml {render_for_api :base, :xml => f}
      format.plist {render_for_api :base, :plist => f}
      format.xmlplist {render_for_api :base, :xmlplist => f}
      format.json {render_for_api :base, :json => f}
    end
  end
  
  private
  def extract(format)
    
  end
end