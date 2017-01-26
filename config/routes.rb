Rails.application.routes.draw do
  resources :quotes
  devise_for :members
  resources :interpretations
  root :to => 'birthdays#new'
  resources :lookups
  resources :birthdays
  resources :places
  resources :spreads
  resources :cards
  resources :faces
  resources :suits
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
