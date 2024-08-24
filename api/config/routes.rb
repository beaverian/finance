Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # API namespace for versioning and multi-tenant admin functionalities
  namespace :api do
    namespace :v1 do
      post 'login', to: 'sessions#create'
      post 'register', to: 'registrations#create'
      namespace :admin do
        resources :users, only: [:index, :show, :create, :update, :destroy]
        resource :settings, only: [:show, :update]
        # You can add more routes here for AR/AP system
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end

