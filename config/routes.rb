Trunk::Application.routes.draw do
  
  resources :posts do
    match '/like' => 'posts/likes#create', :via => :post
    match '/like' => 'posts/likes#destroy', :via => :destory
  end
  
  resources :sharings
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations'}
  match 'users/auth/picbounce' => 'users/picbounce_callback#picbounce_callback', :via => :get
  
 
  match 'users/:id/feed/:service_id' => 'users/feed#external', :as => 'user_external_feed'
  match 'users/:id/feed'      => 'users/feed#show', :as => 'user_feed'
  match 'users/:id/filters' => 'users/filters#index',:via =>:get
  match 'users/:id/follows' => 'users/follows#index', :as => 'user_follows'
  match 'users/:id/followed-by' => 'users/followedby#index', :as => 'user_followedby'
  match 'users/:id/device' => 'users/device#create', :via => :post

  resources :followings

 
  
  match 'recent/:id' => 'posts#recent', :via => :get
  match 'admin' => 'admin#index', :via => :get
  match 'admin/generateSitemap' => 'admin#generateSitemap', :via => :get
  
  match 'download' => 'application#download', :via => :get
  match 'Download' => 'application#download', :via => :get
  match 'appstore' => 'application#appstore', :via => :get
  
  match 'posts' => 'posts#create', :via => :post
  match 'posts' => 'posts#destory', :via => :delete
  match 'tweetie' => 'posts#tweetie', :via => :post
  
  match 'filters/index' => 'filters#index', :via => :get
  match 'filters/current_version' => 'filters#current_version', :via => :get

#API  
  match 'api/users/:id'             => 'api#user',                  :via => :get
  match 'api/users/:id/feed'        => 'api#user_feed',             :via => :get
  match 'api/users/:id/posts'       => 'api#user_posts',            :via => :get
  match 'api/posts/:id'             => 'api#post',                  :via => :get
  match 'api/posts/:id/comments'    => 'api#post_comments',         :via => :get
  
  match 'api/users'                 => 'api#edit_user',             :via => :post
  match 'api/users/:id/followers'   => 'api#create_user_follower',    :via => :post
  match 'api/posts'                 => 'api#create_post',           :via => :post
  match 'api/posts/:id/comments'    => 'api#create_post_comment',   :via => :post
  match 'api/posts/:id/flags'       => 'api#create_post_flag',      :via => :post
  
  match 'api/users/:id/followers/:follower_id'     => 'api#destroy_user_follower',   :via => :delete
  match 'api/posts/:id'             => 'api#destroy_post',          :via => :delete
  match 'api/posts/:id/flags'       => 'api#destroy_post_flag',    :via => :delete
  
  
 #USER 
  match 'users/:user_id/feed'      => 'api#feed', :via => :get
  match 'users/:user_id/profile'   => 'api#profile', :via => :get
  match 'users/:user_id/followers' => 'api#followers', :via => :get
 
 
  match 'users/:user_id/filters' => 'api#filters', :via => :get

  match 'users/:user_id/following' => 'api#destroy_following', :via => :delete
  match 'users/:user_id/followers' => 'api#create_following', :via => :post
  match 'users/:user_id/following' => 'api#create_following', :via => :post
  
  match 'users/:id' => 'profiles', :action => 'show', :as => 'profile', :via => :get
  match 'users/:id' => 'profiles', :action => 'show', :as => 'user', :via => :get
  
#Analytics
  match 'analytics' => 'analytics#viewer', :via => :get
  match 'analytics/refreshFlurry' => 'analytics#refreshFlurry', :via => :get
  match 'analytics/clixtrAnalytics.swf' => 'analytics#analytics', :via => :get
  match 'data/analyticsUniverse.xml' => 'analytics#analyticsUniverse', :via => :get
  match 'data/dataItemListForAnalytics.xml' => 'analytics#analyticsMetrics', :via => :get
  match 'analytics/ga' => 'analytics#ga', :via => :get
  match 'analytics/flurry' => 'analytics#flurry', :via => :get
  match 'analytics/inhouse' => 'analytics#inhouse', :via => :get
  

#Default is assuemed to be a shorterned url  
  match '/:id' => 'posts#show', :via => :get, :as => 'photo'
  match '/:id' => 'posts#edit', :via => :post 
  match '/:id' => 'posts#destroy', :via => :delete

  #mocks
  match '/mocks/page_0' => 'mocks#page_0'
  match '/mocks/page_2' => 'mocks#page_2'
  match '/mocks/page_3' => 'mocks#page_3'
  
  
  root :to => "users/feed#show"

end