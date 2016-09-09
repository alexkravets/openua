Rails.application.routes.draw do
  root 'home#index'
  resources :tenders, only: %w(index show)
  resources :companies, only: %w(index show)
  resources :tender_bundles, only: %w(show)

  post :telegram, to: 'telegram#receive'
end
