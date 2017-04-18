Rails.application.routes.draw do
  resources :quotes
  devise_for :members
  resources :interpretations do
    collection do
      get 'ids'
    end
  end
  root :to => 'birthdays#new'
  resources :lookups
  resources :birthdays do
    member do
      get :last_year
      get :last_planet
    end
  end
  resources :places
  resources :spreads
  resources :cards
  resources :faces
  resources :suits
  
  get '/getresponse_data_endpoint' => 'members#accept_getresponse_data', :as => 'getresponse_data_endpoint'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
