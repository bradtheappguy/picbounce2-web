DEFAULT_PAPERCLIP_OPTIONS = {}

DEVISE_MAILER_FROM       = "please-change-me@example.com"
LIVE_PERSONS_EMAIL       = 'help@example.com'

ACEBOOK_APP_PERMISSIONS = "email,offline_access,publish_stream"

DEFAULT_FB_SHARE_IMAGE   = "http://localhost:3000/images/missing.png"
DEFAULT_FB_POST_NAME     = "This Site's Name"

DEFAULT_PAGE_TITLE       = "This Site's Name"
DEFAULT_PAGE_DESCRIPTION = "This Site's Name"
DEFAULT_SHARE_URL        = "http://localhost:3000"


require File.expand_path('../application', __FILE__)

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Trunk::Application.initialize!
