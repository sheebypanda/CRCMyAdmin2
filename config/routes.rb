Rails.application.routes.draw do
  resources :recettes
  resources :localisations
  resources :lignes
  resources :operateurs
  resources :equipements
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
