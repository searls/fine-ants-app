Rails.application.routes.draw do
  namespace :admin do
    resources :accounts
    resources :banks
    resources :snapshots
    resources :users

    root to: "accounts#index"
  end

  resources :fine_ants
  resource :dashboard

  root "dashboards#show"
end
