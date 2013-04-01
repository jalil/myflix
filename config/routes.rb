Myflix::Application.routes.draw do

  get 'register', :to =>"users#new"
  get 'signup/:invitation_token', :to =>"users#new", as: 'invite_register'

  get 'login', :to =>"sessions#new"
  post 'login', :to => 'sessions#create'
  get 'logout', :to => 'sessions#destroy'

  get "videos/index"
  get 'home',  :to=> "videos#index"
  get 'my_queue',  :to=> "line_items#index"
  get 'people',  :to=> "friendships#index"
  post 'update_line',  to:  "line_items#update_line"


  get 'ui(/:action)', controller: 'ui'
  #root page
  root :to => "pages#front"

  resources :pages
  resources :payments
  resources :line_items, only: [:create, :destroy]
  resources :reviews, only: [:create]
  resources :users
  resources :friendships, only: [:create] 

  get 'password_reset', to: 'password_reset#index'
  post 'password_reset', to: 'password_reset#create', as: 'create_password_reset'
  get 'password_reset/:token', to: 'password_reset#edit', as: 'edit_password_reset'
  put 'password_reset/:token', to: 'password_reset#update', as: 'update_password_reset'


  get 'update_account', to: 'users#update'

  resources :invitations, only:[:create, :new]

  namespace :admin do
    resources :videos, only:[:create,:index,:edit, :new]
  end

  resources :videos do
    resources :reviews
  end
  resources :videos, only: [:show] do
    collection do
       post "search", to: "videos#search"
    end
  end
 end
