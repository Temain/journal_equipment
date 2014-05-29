Rails.application.routes.draw do
  root 'equipment#index'
  resources :equipment

  devise_for :users
  get 'persons/profile', as: 'user_root'
  get 'history/:id' => 'history#show', as: 'history'
  post 'equipment/:id/relocation' => 'equipment#relocation', as: 'relocation'
  post 'equipment/:id/repair' => 'equipment#repair', as: 'repair'

  get 'import' => 'import#index', as: 'import'
  post 'upload' => 'import#upload', as: 'upload'

  # returning JSON for typeaheads
  get 'load_manufacturers' => 'equipment#load_manufacturers', as: 'manufacturers'
  get 'load_equipment' => 'equipment#load_equipment', as: 'load_equipment'
  get 'load_spares/:equipment_type_id' => 'equipment#load_spares', as: 'load_spares'

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
