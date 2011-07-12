require 'omniauth/basic'
require 'nokogiri'

module OmniAuth
  module Strategies
    class FacebookSso < HttpBasic
      def initialize(app)
        super(app, :facebooksso, nil)
      end
      
      def endpoint
        "https://graph.facebook.com/me?access_token=#{request.params['fb_access_token']}"
      end
      
      def perform_authentication(endpoint)
        super(endpoint)
      end
      
      def user_data
        @data ||= MultiJson.decode(@response.body)
      end
      
      def auth_hash
        OmniAuth::Utils.deep_merge(super, {
          'uid' => user_data['id'],
          'user_info' => user_info,
          'extra' => {'user_hash' => user_data}
        })
      end
      
      def user_info
        {
          'nickname' => user_data["link"].split('/').last,
          'email' => (user_data["email"] if user_data["email"]),
          'first_name' => user_data["first_name"],
          'last_name' => user_data["last_name"],
          'name' => "#{user_data['first_name']} #{user_data['last_name']}",
          'image' => "http://graph.facebook.com/#{user_data['id']}/picture?type=square",
          'urls' => {
            'Facebook' => user_data["link"],
            'Website' => user_data["website"],
          }
        }
      end
      
      def get_credentials
        OmniAuth::Form.build({:title => 'Facebook Authentication'}) do
          text_field 'Facebook App ID', 'fb_app_id'
          text_field 'Access Token', 'fb_access_token'
          password_field 'Access Token Expiration', 'expires'
        end.to_response
        
      end
    end
  end
end