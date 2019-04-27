Rails.application.routes.draw do
  namespace :admin do
    resources :accounts
    resources :banks
    resources :snapshots
    resources :users
    resources :wages

    root to: "accounts#index"
  end

  resources :fine_ants
  resource :dashboard do
    get "snapshot-chart-data", to: "dashboards#snapshot_chart_data"
  end

  root to: redirect("/dashboard")
end
