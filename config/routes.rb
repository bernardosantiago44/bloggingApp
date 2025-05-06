Rails.application.routes.draw do
  resources :blogs, only: [ :index, :show, :new, :create ]

  # Rutas existentes
  get "users/new"
  get "users/create"
  get "pages/home"
  resource :session
  resources :passwords, param: :token

  resources :blogs do
    resources :comments, only: [ :create ]
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "up" => "rails/health#show", as: :rails_health_check

  # Authentication routes
  get "/signup", to: "users#new", as: :signup
  post "/signup", to: "users#create", as: :create_user

  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy", as: :logout

  # Profile routes
  get "/profile", to: "users#show", as: :profile
  patch "/profile", to: "users#update", as: :update_profile

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "pages#home", as: :root
end
