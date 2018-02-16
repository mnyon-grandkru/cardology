Rails.application.routes.draw do
  resources :quotes
  devise_for :members, :controllers => {:sessions => 'sessions', :passwords => 'passwords'}
  
  authenticated :member do
    root :to => 'birthdays#mine'
  end
  
  resources :subscriptions, :only => [:new, :create, :update] do
    collection do
      delete :cancel
    end
  end
  
  resources :interpretations do
    collection do
      get 'ids'
    end
  end
  root :to => 'birthdays#new'
  resources :birthdays do
    member do
      get :replace_card
      get :personality_for_zodiac
    end
  end
  resources :places
  resources :spreads
  resources :cards
  resources :faces
  resources :suits
  resources :members, :only => :index
  
  post '/member_save' => 'members#create', :as => 'member_save'
  put '/member_assign_zodiac/:id' => 'members#update', :as => 'member_assign_zodiac'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
