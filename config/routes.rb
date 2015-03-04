Rails.application.routes.draw do
  # You can have the root of your site routed with "root"
  root 'parkings#index'

  # get 'parkings/' => 'parkings#index'
  # get 'parkings/new' => 'parkings#new'
  # post 'parkings' => 'parkings#create'
  # get 'parkings/:id' => 'parkings#show'
  # get 'parkings/:id/edit' => 'parkings#edit'
  # delete 'parkings/:id' => 'parkings#destroy'
  # patch 'parkings/:id' => 'parkings#update'
  # put 'parkings/:id' => 'parkings#update'

  resources :parkings do
    resources :place_rents, only: [:new, :create]
  end
  resources :place_rents, only: [:show, :index, :destroy]
  resources :cars
  resource :session


  # get 'place_rents' => 'place_rents#index'
  # get 'place_rents/:id' => 'place_rents#show'
  # get 'parkings/:id/place_rents/new' => 'place_rents#new'
  # post 'parkings/place_rents' => 'place_rents#create'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".



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
