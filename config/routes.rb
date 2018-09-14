Rails.application.routes.draw do
  resources :incidents
  resources :projets
  resources :recettes
  resources :localisations do
    collection { post :import }
  end
  resources :lignes do
    collection { post :import }
  end
  resources :operateurs
  resources :equipements do
    collection { post :import }
  end

  resources :search, only: [:index]

  devise_for :users

  root 'recettes#dashboard'
  get '/stock', to: 'equipements#stock'
  get '/fichesrecettes', to: 'recettes#exportcsv'
  get '/serials_update', to: 'equipements#serials_update'
  get '/hosts_update', to: 'equipements#hosts_update'
end
