Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post 'create_user', to: "stripes#create_user"
  post "/create_stripe_user", to: "stripes#create_stripe_user"
  post "/create_product", to: "stripes#create_product"
  get '/checkout', to: "stripes#checkout"

  # Defines the root path route ("/")
  # root "posts#index"
end
