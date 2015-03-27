Rails.application.routes.draw do
  get 'trade_request/:id' => 'trade#trade_request', as: 'trade_request'
  get 'incoming_trade_request' => 'trade#incoming_trade_request', as: 'incoming_trade_request'
  post '/accept_shift/:id/accept_shift', to:'trade#accept_shift', as: 'accept_shift'
 resources :trade_request,  :except => [:index, :new, :update, :create, :destroy, :edit, :show] do
   member do
     put '' => 'trade#send_request'
     patch '' => 'trade#send_request'
  end
 end
  

 
 

  get 'shift_trade_board' => 'posted_shift#index', as: 'shift_trade_board'
  post 'post_shift' => 'posted_shift#post_shift', as: 'post_shift' 
  post '/cancel_shift/:id/remove', to:'posted_shift#cancel_shift', as: 'cancel_shift'
  post '/pick_up_shift/:id/pickup', to:'posted_shift#pick_up_shift', as: 'pick_up_shift'
  resources :shifts

  get 'calendar' => 'calendar#index', as:'calendar'

  devise_for :users
  root 'staticpages#home'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
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

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
