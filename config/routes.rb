Rails.application.routes.draw do
  devise_for :users

  resources :memberships

  resources :organizations do
    member do
      get 'analytics'
    end
  end

  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root "organizations#index"
end
