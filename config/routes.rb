Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tenders#index'
  resources :tenders, only: %w(show)
  resources :companies, only: %w(index show)
  resources :tender_bundles, only: %w(show)
end
