Rails
  .application
  .routes
  .draw do
    get 'seats/create'
    devise_for :users
    post 'select_seat', to: 'bookings#select_seat', as: 'select_seat'
    get 'finalize', to: 'bookings#finalize', as: 'final'

    post 'bookings', to: 'bookings#create'

    root to: 'admin/movies#index'
    namespace :admin do
      resources :movies do
        collection { get 'search' }
      end
      resources :shows do
        collection { get 'show_theatre' }
      end
      resources :theatres
    end

    resources :bookings, only: %i[index new create show] do 
      collection { get 'booking_history' }
    end
    post "checkouts/create", to: 'checkouts#create' 
    post "checkouts/new", to: 'checkouts#new' 
    # get 'bookings/generate', to: 'bookings#generate'
   

    # root to: "home#index"
    # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

    # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
    # Can be used by load balancers and uptime monitors to verify that the app is live.
    get 'up' => 'rails/health#show', :as => :rails_health_check

    # Defines the root path route ("/")
    # root "posts#index"
  end
