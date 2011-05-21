require 'omniauth/basic'
require 'nokogiri'
require "base64"
    
module OmniAuth
  module Strategies
    class Posterous < HttpBasic
      def initialize(app)
        super(app, :posterous, nil)
      end
      
      def basic_auth_fields
      	CGI.escape(request.params['username'])+":"+CGI.escape(request.params['password'])
      end
      
      def endpoint
      	"http://"+basic_auth_fields+"@posterous.com/api/2/auth/token"
      end
      
      def userInfoPoint
      	"http://"+basic_auth_fields+"@posterous.com/api/2/users/me?api_token="+@token
      end
      
      def perform
      	#get token
        tokenResponse = perform_authentication(endpoint)
        @token = MultiJson.decode(tokenResponse.body)['api_token']
        
        #get user info
        @response = perform_authentication(userInfoPoint)
        @env['omniauth.auth'] = auth_hash
        @env['REQUEST_METHOD'] = 'GET'
        @env['PATH_INFO'] = "#{OmniAuth.config.path_prefix}/facebook/callback"

        call_app!
      rescue RestClient::Request::Unauthorized => e
        fail!(:invalid_credentials, e)
      end
      
      
      def user_data
        @data ||= MultiJson.decode(@response.body)
      end
      
      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid' => "#{user_data['id']}",
          'user_info' => user_info,
          'credentials' => credentials,
          'extra' => {'user_hash' => user_data}
        })
      end
      
      def credentials
      	{
      		'token' => @token,
      		'secret' =>  Base64.encode64(basic_auth_fields)
      		
      	}
      end
      
      def user_info
        {
          'nickname' => user_data["nickname"],
          'email' => request.params["username"],
          'first_name' => (user_data["first_name"] if user_data["first_name"]),
          'last_name' => (user_data["last_name"] if user_data["last_name"]),
          'name' => user_data['nickname'],
          'image' => user_data['profile_pic']
        }
      end
     
           
      def get_credentials
        OmniAuth::Form.build({:title => 'Posterous Authentication'}) do
          text_field 'Username', 'username'
          password_field 'Password', 'password'
        end.to_response
      end
    end
  end
end