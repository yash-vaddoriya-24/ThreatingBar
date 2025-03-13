Rails.application.routes.draw do
  get "redeems/index"
  get "combos/index"
  devise_for :users
  # get "users/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "services-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  root "users#index"
  get "/change_password", to: "users#change_password", as: :change_password
  patch "/update_password", to: "users#update_password", as: :update_password

  resources :customers
  resources :users
  resources :services
  resources :combos do
    collection do
      get "select_combos"      # Page to select combos
      get "assign_customer"    # Page to select customer
      post "assign"            # Action to save the assignment
    end
  end

  # This removes the show route

  get "combos/select_combos", to: "combos#select_combos", as: "select_combos"
  post "combos/choose_customer", to: "combos#choose_customer", as: "choose_customer"
  get "combos/assign_customer", to: "combos#assign_customer", as: "assign_customer"
  post "combos/assign", to: "combos#assign_combo", as: "assign_combo"
end
