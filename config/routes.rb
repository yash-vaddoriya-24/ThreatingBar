Rails.application.routes.draw do
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
  resources :combos
end
