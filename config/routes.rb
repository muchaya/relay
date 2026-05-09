Rails.application.routes.draw do
  root "homes#show"

  resource :registration
  resource :session
  resources :passwords, param: :token
  
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  get "/demo", to: "static#demo"
  
  resources :bookings, only: [ :new, :create, :show ]
  resources :routes, only: [:index]
  resources :trips, only: [:new, :show]
  resources :vehicles, only: [:index, :new, :create]


  resources :bookings do
    scope module: 'bookings' do
      resources :payments, only: [ :create, :show ]
    end
  end

  namespace :account do
    resources :trips, only: [:index]
  end

  resource :onboardings, only: :show

  resources :build_trip, only: %i[update show], controller: "form_steps/trip_steps"
  
  get "/for-drivers", to: "static#for_drivers"
  get "/for-passengers", to: "static#for_passengers"
end
