Trunk::Application.routes.draw do
# The priority is based upon order of creation
  resources :sharings
  match 'users/auth/picbounce' => 'users/picbounce_callback#picbounce_callback', :via => :get
  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callbacks", :registrations => 'registrations'}
 
  resources :authentications

  match 'login' => 'sessions#new', :via => :get
  match 'login' => 'sessions#create', :via => :post
  match 'logout' => 'sessions#destory', :via => :get
  match 'connect' => 'photos#connect', :via => :get
  match '/:id/logout' => 'sessions#destory', :via => :get
  
  match 'fb/:id' => 'application#fb_post_authorize', :via => :get
  match 'fb/:id' => 'application#fb_post_authorize', :via => :post
  
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
  match '/auth/:provider/callback' => 'authentications#create'

  match 'filters/test2' => 'filters#test2', :via => :get

#API
  match 'api/popular' => 'api#popular', :via => :get
  match 'api/nearby'  => 'api#nearby',  :via => :get
  match 'api/mentions' => 'api#mentions', :via => :get

  match 'users/:user_id/feed' => 'api#feed', :via => :get
  match 'users/:user_id/profile' => 'api#profile', :via => :get
  match 'users/:user_id/followers' => 'api#followers', :via => :get
 
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
  
  match '/profiles/:id' => 'profiles', :action => 'show', :as => 'profile', :via => :get
  
  match '/:id' => 'photos#view', :via => :get
  match '/:id' => 'photos#edit', :via => :post
  match '/:id' => 'photos#destory', :via => :delete


# first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
   root :to => "photos#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end




