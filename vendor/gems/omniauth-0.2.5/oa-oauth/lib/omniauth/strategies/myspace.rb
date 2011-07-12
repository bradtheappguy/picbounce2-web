require 'omniauth/oauth'

module OmniAuth
  module Strategies
    #
    # Authenticate to Tumblr via OAuth and retrieve basic
    # user information.
    #
    # Usage:
    #
    #    use OmniAuth::Strategies::Tumblr, 'consumerkey', 'consumersecret'
    #
    class Myspace < OmniAuth::Strategies::OAuth
      # Initialize the middleware
      #
      # @option options [Boolean, true] :sign_in When true, use the "Sign in with Tumblr" flow instead of the authorization flow.
      def initialize(app, consumer_key = nil, consumer_secret = nil, options = {}, &block)

        client_options = {:http_method=>"get", :site=>"http://api.myspace.com", :request_token_path=>"/request_token", :access_token_path=>"/access_token", :authorize_path=>"/authorize"}
        
        super(app, :myspace, consumer_key, consumer_secret, client_options, options)
      end

      def auth_hash
        puts "AUTH HASH!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        OmniAuth::Utils.deep_merge(super, {
          'uid' => user_data['id'],
          'user_info' => user_info,
          'extra' => { 'user_hash' => user_data }
        })
      end

      def user_info
        
        puts "USER INFO!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
        {
          'nickname' => user_data['nickname'],
          'name' => user_data['displayName'],
          'image' => user_data['thumbnailUrl'],
          'urls' => {
            'website' => user_data['profileUrl'],
          }
        }
      end

      #def user
      #  tumblelogs = user_hash['myspace']['ddd']
      #  if tumblelogs.kind_of?(Array)
      #    @user ||= tumblelogs[0]
      #  else
      #    @user ||= tumblelogs
      #  end
      #end

      def user_hash
        url = "http://api.myspace.com/v2/people/@me/@self?format=json"
        responce = @access_token.get(url)
        body = responce.body
        @user_hash ||= Hash.from_xml(body)
        
      end
      
      def user_data
        url = "http://api.myspace.com/v2/people/@me/@self?format=json"
        @data ||= MultiJson.decode(@access_token.get(url).body)['entry']
      end
    end
  end
end