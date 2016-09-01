Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'tenders#index'
  get '/tenders/:id' => 'tenders#show', as: :tenders_show
end
