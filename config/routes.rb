Rails.application.routes.draw do
  resources :recettes
  resources :localisations
  resources :lignes
  resources :operateurs
  resources :equipements
  devise_for :users

  root 'equipements#index'
end
