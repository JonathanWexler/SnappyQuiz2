Snappyquiz2::Application.routes.draw do


  resources :questions
  # resources :quiz

  devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' } do
    # get '/users/sign_out' => 'devise/sessions#destroy'
  end
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  # devise_for :users, :controllers => { omniauth_callbacks: 'omniauth_callbacks' }
  # match '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy' #, :as => :destroy_user_session
  # end

  # ERROR PAGES
  get "errors/file_not_found"
  get "errors/unprocessable"
  get "errors/internal_server_error"
  match '/404', to: 'errors#file_not_found', via: :all
  match '/422', to: 'errors#unprocessable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # QUIZ PAGES 
  get "quiz/ended_early"
  get "quiz/index"  
  post "quiz/start"
  get "quiz/question"
  post "quiz/question"
  post "quiz/answer"
  get "quiz/end"

  # CHOICE PAGES
  post "choices/create"
  post "choices/destroy"

  # QUESTION PAGES
  get "questions/index"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'users#home'

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
