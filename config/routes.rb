Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#dashboard"
  resources :patients, only: [] do
    resources :glucometer_readings, only: [:index, :create]
  end
end
