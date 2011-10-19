Trunk::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # In the development environment your application's code is reloaded on
  # every request.  This slows down response time but is perfect for development
  # since you don't have to restart the webserver when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  config.active_support.escape_html_entities_in_json = false
  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end


#Facebook
FACEBOOK_APP_ID          = "161007653957731"
FACEBOOK_APP_SECRET      = "7a6210cb93220c5509f6ff8f8d872314"

#Twitter
TWITTER_SECRET_KEY       = "L0LJGa5g4TWNUJfK9jmACNt3i2P2ykUw0TVbysQinIg"
TWITTER_CONSUMER_KEY     = "D4sOenvRrSaI1GIGTTEeSQ"

MYSPACE_OAUTH_KEY        = "129a778985934769a01e98c85f0496b1"
MYSPACE_OAUTH_SECRET	     = "3f0b59f73fc947868f403f5e025fba2d5d1efc14e6c64dac882f39e2688f6219"

#Flickr
   #http://www.flickr.com/services/apps/72157626418174343/auth/  
   #App Creator: bradsmithinc@ymail.com
FLICKR_KEY		           = "ffa00b627e93f748069131eb6fc1ca3f"
FLICKR_SECRET		         = "56ba4e8669deee83"


#Tumblr
TUMBLR_OAUTH_KEY = "LO8YVBI64F4qSAN5OhQDB2ZyET51PNhEKTRwP9W1tqivyrabYA"
TUMBLR_OAUTH_SECRET = "CTP7UdYAv5eoQsYVsDr96mdWjgjV2UHyA6SOyabGyVQNUwfFQV"

