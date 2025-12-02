Rails.application.routes.draw do
  # Devise routes for authentication
  devise_for :users

  # Root route
  root "home#index"

  # Items (fridge inventory)
  resources :items do
    collection do
      get "scan_fridge"
      post "analyze_image"
    end
  end

  # Recipes (meal suggestions)
  resources :recipes, only: [:index]

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check
end
