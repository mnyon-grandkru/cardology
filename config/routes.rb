Rails.application.routes.draw do
  resources :deliveries do
    collection do
      get :entrance
    end
    member do
      get :access
    end
  end
  
  resources :interviews do
    collection do
      get :review
    end
  end
  resources :celestials
  resources :quotes
  devise_for :members, :controllers => {:sessions => 'sessions', :passwords => 'passwords'}
  
#   authenticated :member do
#     root :to => 'birthdays#mine'
#   end
  
  resources :subscriptions, :only => [:new, :create, :update] do
    member do
      get :manage
    end
    collection do
      post :upgrade
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
      get :browse
    end
  end
  resources :places
  resources :spreads
  resources :cards
  resources :faces
  resources :suits
  resources :members, :only => :index
  
  get '/calendars/mine' => 'calendars#mine'
  get '/calendars/ours' => 'calendars#ours'
  
  get '/guidances/prompt' => 'guidances#prompt'
  get '/guidances/show' => 'guidances#show'
  post '/guidances/show' => 'guidances#show'
  post '/guidances/flip_cards' => 'guidances#flip_cards'
  get '/guidances/personality' => 'guidances#personality'
  get '/guidances/daily_card' => 'guidances#daily_card'
  get '/guidances/card52' => 'guidances#card52'
  get '/guidances/year_card' => 'guidances#year_card'
  post '/guidances/payment' => 'guidances#payment'
  get '/guidances/staging_payment' => 'guidances#staging_payment'
  get '/guidances/initialize_payment' => 'guidances#initialize_payment'
  get '/guidances/lookup_cards' => 'guidances#lookup_cards'
  get '/guidances/choose_date' => 'guidances#choose_date'
  get '/guidances/receive_reading' => 'guidances#choose_date'
  post '/guidances/receive_reading' => 'guidances#receive_reading'
  get '/guidances/planet/:planet(/:position)' => 'guidances#planet', :as => 'planet_guidance'
  get '/guidances/card_box' => 'guidances#card_box'
  get '/guidances/octagon' => 'guidances#octagon'
  get '/guidances/cube' => 'guidances/cube'
  get '/login_page' => "birthdays#login_page"


  post '/member_save' => 'members#create', :as => 'member_save'
  put '/member_assign_zodiac/:id' => 'members#update', :as => 'member_assign_zodiac'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
