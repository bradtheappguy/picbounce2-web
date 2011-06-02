class Users::FiltersController < ApplicationController
 
	def index
		user = User.find_by_id(params[:id])
		f = user.filters
		
		 respond_to do |format|
	      format.xml {render_for_api :base, :xml => f}
	      format.plist {render_for_api :base, :plist => f}
	      format.xmlplist {render_for_api :base, :xmlplist => f}
	      format.json {render_for_api :base, :json => f}
	    end
	end

end
