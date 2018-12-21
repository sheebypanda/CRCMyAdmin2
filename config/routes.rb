Rails.application.routes.draw do
  resources :incidents, :projets, :recettes, :operateurs

  resources :localisations do
    collection { post :import }
  end

  resources :lignes do
    collection { post :import }
  end

  resources :equipements do
    collection { post :import }
  end

  resources :search, only: [:index]

  devise_for :users

  root 'recettes#dashboard'
  get '/stock', to: 'equipements#stock'
  get '/map', to: 'recettes#map'
  get '/fichesrecettes', to: 'recettes#exportcsv'
  get '/enr', to: 'recettes#enr'
  get '/serials_update', to: 'equipements#serials_update'
  get '/hosts_update', to: 'equipements#hosts_update'
  delete '/delete_image_localisation', to: 'localisations#delete_image'
end
