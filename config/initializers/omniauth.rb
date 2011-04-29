Rails.application.config.middleware.use OmniAuth::Builder do
   provider :twitter, 'jVH9flMowPp9rb1qrJshYQ', '0rGIdddh2cwS8xn6ZmRpk2IFjBVsYvj2ov1onGVytc'
   provider :facebook, '161007653957731', '7a6210cb93220c5509f6ff8f8d872314'
   provider :flickr, 'ffa00b627e93f748069131eb6fc1ca3f', '56ba4e8669deee83'
   provider :foursquare, 'PIBSQUQ5TX55WUVBUHFQLYMXPCKUX1PXY54VEFL5UC11GL2X', 'XQBE14F3YY5RHZCXAFLGUNRXHW1JJ2H5BYRC05M2H4ZCNYLB'
   provider :tumblr, 'LO8YVBI64F4qSAN5OhQDB2ZyET51PNhEKTRwP9W1tqivyrabYA', 'CTP7UdYAv5eoQsYVsDr96mdWjgjV2UHyA6SOyabGyVQNUwfFQV'
   provider :instagram, '19667f5f3a2e48c2bd382421096a871f', '3e4826aa50df4c849292b9ad7096dd40'

   #waiting on OmniAuth integration
   #provider :dropbox,  '1rryllzb4op6wvc', '7ejqb8kmx2213ww'
   
   #Waiting on API beta approval 
   #provider :picplz
end


Rails.application.config.middleware.use OmniAuth::Strategies::HttpBasic, :http_basic, 'foo', 'http://test.com'
