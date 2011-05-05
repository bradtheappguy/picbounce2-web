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
  config.action_view.debug_rjs             = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  config.active_support.escape_html_entities_in_json = false
end

FACEBOOK_APP_ID          = "161007653957731"
FACEBOOK_APP_SECRET      = "7a6210cb93220c5509f6ff8f8d872314"
TWITTER_SECRET_KEY       = "L0LJGa5g4TWNUJfK9jmACNt3i2P2ykUw0TVbysQinIg"
TWITTER_CONSUMER_KEY     = "D4sOenvRrSaI1GIGTTEeSQ"


