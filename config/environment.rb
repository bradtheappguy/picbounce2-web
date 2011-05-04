DEFAULT_PAPERCLIP_OPTIONS = {}

DEVISE_MAILER_FROM       = "please-change-me@example.com"
LIVE_PERSONS_EMAIL       = 'help@example.com'

FACEBOOK_APP_ID          = "161007653957731"
FACEBOOK_APP_SECRET      = "7a6210cb93220c5509f6ff8f8d872314"
FACEBOOK_APP_PERMISSIONS = "email,offline_access,publish_stream"

DEFAULT_FB_SHARE_IMAGE   = "http://localhost:3000/images/missing.png"
DEFAULT_FB_POST_NAME     = "This Site's Name"

DEFAULT_PAGE_TITLE       = "This Site's Name"
DEFAULT_PAGE_DESCRIPTION = "This Site's Name"

TWITTER_SECRET_KEY       = "L0LJGa5g4TWNUJfK9jmACNt3i2P2ykUw0TVbysQinIg"
TWITTER_CONSUMER_KEY     = "D4sOenvRrSaI1GIGTTEeSQ"

DEFAULT_SHARE_URL        = "http://localhost:3000"


require File.expand_path('../application', __FILE__)

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Trunk::Application.initialize!
