Rails.application.routes.draw do
  resources :livraisons
  resources :incidents, :projets, :recettes, :operateurs, :livraisons

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
  get '/enr', to: 'equipements#enr'
  get '/map', to: 'recettes#map'
  get '/fichesrecettes', to: 'recettes#exportcsv'
  get '/enr', to: 'recettes#enr'
  get '/serials_update', to: 'equipements#serials_update'
  get '/hosts_update', to: 'equipements#hosts_update'
  get '/get-pic-by-ip/', to: 'recettes#getPic'
  delete '/delete_image_localisation', to: 'localisations#delete_image'
  delete '/delete_pv_livraison', to: 'livraisons#delete_pv'
end
