Trunk::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite.  You never need to work with it otherwise.  Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs.  Don't rely on the data there!
  config.cache_classes = true

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Use SQL instead of Active Record's schema dumper when creating the test database.
  # This is necessary if your schema can't be completely dumped by the schema dumper,
  # like if you have constraints or database-specific column types
  # config.active_record.schema_format = :sql

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
end

FEATURE_LOGINS_ENABLED   = true

FACEBOOK_APP_ID          = "221310351230872"
FACEBOOK_APP_SECRET      = "98db48a9fd117ab622ff3a500d24e1c6"

TWITTER_SECRET_KEY       = "9fVkuQ55t8Z6wfvnuA0oL2HXd6y5ixhxDlQMxjKMm0M"
TWITTER_CONSUMER_KEY     = "fWqlifbApc14jPJWErfQ"

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
