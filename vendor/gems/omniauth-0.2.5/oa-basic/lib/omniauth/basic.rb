require 'omniauth/core'

module OmniAuth
  module Strategies
    autoload :HttpBasic,  'omniauth/strategies/http_basic'
    # autoload :Gowalla,    'omniauth/strategies/gowalla'
    autoload :FacebookSso,  'omniauth/strategies/facebook_sso'
    autoload :Posterous,  'omniauth/strategies/posterous'
    
  end
end
