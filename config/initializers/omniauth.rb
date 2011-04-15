Rails.application.config.middleware.use OmniAuth::Builder do
   provider :twitter, 'jVH9flMowPp9rb1qrJshYQ', '0rGIdddh2cwS8xn6ZmRpk2IFjBVsYvj2ov1onGVytc'
   provider :facebook, '161007653957731', '7a6210cb93220c5509f6ff8f8d872314'
end
