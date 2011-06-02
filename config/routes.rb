Trunk::Application.routes.draw do
  resources :sharings

  
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations'}
  match 'users/auth/picbounce' => 'users/picbounce_callback#picbounce_callback', :via => :get
  
  match 'users/:id/feed'      => 'users/feed#show', :as => 'user_feed'

  match 'users/:id/filters' => 'users/filters#index',:via =>:get
  match 'users/:id/followers' => 'users/followers#index', :as => 'user_following'
  match 'users/:id/followees' => 'users/followees#index', :as => 'user_followees'
  #resources :authentications
  resources :followings

  #match 'login' => 'sessions#new', :via => :get
  #match 'login' => 'sessions#create', :via => :post
  #match 'logout' => 'sessions#destory', :via => :get
  #match 'connect' => 'photos#connect', :via => :get
  #match '/:id/logout' => 'sessions#destory', :via => :get
  
  #match 'fb/:id' => 'application#fb_post_authorize', :via => :get
  #match 'fb/:id' => 'application#fb_post_authorize', :via => :post
  
  match 'recent/:id' => 'photos#recent', :via => :get
  match 'admin' => 'admin#index', :via => :get
  match 'admin/generateSitemap' => 'admin#generateSitemap', :via => :get
  
  match 'download' => 'application#download', :via => :get
  match 'Download' => 'application#download', :via => :get
  match 'appstore' => 'application#appstore', :via => :get
  match 'photos' => 'photos#create', :via => :post
  match 'photos' => 'photos#destory', :via => :delete
  match 'tweetie' => 'photos#tweetie', :via => :post
  

#AUTH
 #match '/auth/:provider/callback' => 'authentications#create'

  match 'filters/index' => 'filters#index', :via => :get
#API
  match 'api/popular' => 'api#popular', :via => :get
  match 'api/nearby'  => 'api#nearby',  :via => :get
  match 'api/mentions' => 'api#mentions', :via => :get

  match 'users/:user_id/feed'      => 'api#feed', :via => :get
  match 'users/:user_id/profile'   => 'api#profile', :via => :get
  match 'users/:user_id/followers' => 'api#followers', :via => :get
 
 
  match 'users/:user_id/filters' => 'api#filters', :via => :get
  match 'users/:user_id/following' => 'api#following', :via => :get
  match 'users/:user_id/following' => 'api#destroy_following', :via => :delete

  match 'users/:user_id/followers' => 'api#create_following', :via => :post



  match 'analytics' => 'analytics#viewer', :via => :get
  match 'analytics/refreshFlurry' => 'analytics#refreshFlurry', :via => :get
  match 'analytics/clixtrAnalytics.swf' => 'analytics#analytics', :via => :get
  match 'data/analyticsUniverse.xml' => 'analytics#analyticsUniverse', :via => :get
  match 'data/dataItemListForAnalytics.xml' => 'analytics#analyticsMetrics', :via => :get
  match 'analytics/ga' => 'analytics#ga', :via => :get
  match 'analytics/flurry' => 'analytics#flurry', :via => :get
  match 'analytics/inhouse' => 'analytics#inhouse', :via => :get
  
  match 'users/:id' => 'users', :action => 'show', :as => 'user', :via => :get
  
  match '/:id' => 'photos#view', :via => :get, :as => 'photo'
  match '/:id' => 'photos#edit', :via => :post
  match '/:id' => 'photos#destory', :via => :delete


  root :to => "photos#index"

end




