require 'omniauth/core'

module OmniAuth
  module Strategies
    autoload :HttpBasic,  'omniauth/strategies/http_basic'
    # autoload :Gowalla,    'omniauth/strategies/gowalla'
    autoload :FacebookSso,  'omniauth/strategies/facebook_sso'
    
  end
end
