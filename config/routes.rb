Rails.application.routes.draw do
  resources :recettes
  resources :localisations
  resources :lignes
  resources :operateurs
  resources :equipements do
    collection { post :import }
  end

  resources :search, only: [:index]

  devise_for :users

  root 'recettes#dashboard'
  get '/stock', to: 'equipements#stock'
  get '/serials_update', to: 'equipements#serials_update'
  get '/hosts_update', to: 'equipements#hosts_update'
end
