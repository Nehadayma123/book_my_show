Rails.application.routes.draw do
  get 'bookings/index'
  # get 'show/index'
  # get 'show/edit'
  # get 'show/show'
  # get 'movies/index'
  # get 'movies/show'
  # get 'movies/new'
  # get 'movies/edit'
  # get 'theatres/index'
  # get 'theatres/show'
  # get 'theatres/new'
  # get 'theatres/destroy'
  
  get 'bookings/booking_history'
  resources :bookings
  resources :shows
  resources :theatres
  devise_for :users
  resources :movies
  
  # root to: "home#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
