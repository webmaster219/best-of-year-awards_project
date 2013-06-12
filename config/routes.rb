BestOfYearAwards::Application.routes.draw do
  resources :submissions


  get "home/index"

  resources :users

  resources :user_sessions
  
  match 'login' => "user_sessions#new",      :as => :login
  match 'logout' => "user_sessions#destroy", :as => :logout
  

  root :to => 'home#index'
end
