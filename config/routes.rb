Trunk::Application.routes.draw do
  
  
  
 
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations'}
  match 'users/auth/picbounce' => 'users/picbounce_callback#picbounce_callback', :via => :get
  
  
#API  
  match 'api/users/:id'             => 'api/users#show',             :via => :get
  match 'api/users/:id/feed'        => 'api/users#feed',             :via => :get
  match 'api/users/:id/posts'       => 'api/users#posts',            :via => :get
  match 'api/posts/:id'             => 'api/posts#show',             :via => :get
  match 'api/posts/:id/comments'    => 'api/posts#comments',         :via => :get
  
  match 'api/users/:id'             => 'api/users#edit',             :via => :put
  match 'api/users/:id/followers'   => 'api/users#create_follower',  :via => :post
  match 'api/posts'                 => 'api/posts#create',           :via => :post
  match 'api/posts/:id/comments'    => 'api/posts#create_comment',   :via => :post
  match 'api/posts/:id/flags'       => 'api/posts#create_flag',      :via => :post
  
  match 'api/users/:id/followers'     => 'api/users#destroy_follower',   :via => :delete
  match 'api/posts/:id'                            => 'api/posts#destroy',            :via => :delete
  match 'api/posts/:id/flags'                      => 'api/posts#destroy_flag',       :via => :delete
  
  

  match 'users/auth/:provider/sign_out' => 'users#omniauth_signout' 
  
  

 #WEB_APP
  
  match '/settings' => 'users#edit', :via => :get
  
  match '/terms' => 'static#terms', :via => :get
  
  match 'users/:id/feed'      => 'users/feed#show', :as => 'user_feed'
  match 'users/:id'           => 'users', :action => 'show', :as => 'profile', :via => :get
  match 'users/:id'           => 'users', :action => 'show', :as => 'user',    :via => :get
  
  
#Default is assuemed to be a shorterned url  
  match '/:id' => 'posts#show', :via => :get, :as => 'photo'
  match '/:id' => 'posts#edit', :via => :post 
  match '/:id' => 'posts#destroy', :via => :delete
  match '/posts/callback' => 'posts#callback', :via => :get
  resources :posts 
  
  root :to => "users/feed#show"

end