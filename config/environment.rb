DEFAULT_PAPERCLIP_OPTIONS = {}

DEVISE_MAILER_FROM       = "contant@picbounce.com"
LIVE_PERSONS_EMAIL       = 'contant@picbounce.com'

FACEBOOK_APP_PERMISSIONS = "email,offline_access,publish_stream,read_stream,user_photos,friends_photos"

DEFAULT_FB_SHARE_IMAGE   = "http://localhost:3000/images/missing.png"
DEFAULT_FB_POST_NAME     = "PicBounce"

DEFAULT_PAGE_TITLE       = "PicBounce"
DEFAULT_PAGE_DESCRIPTION = "PicBounce is the world's fastest way to share your photos on facebook and twitter"
DEFAULT_SHARE_URL        = "http://localhost:3000"

require File.expand_path('../application', __FILE__)

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Trunk::Application.initialize!
