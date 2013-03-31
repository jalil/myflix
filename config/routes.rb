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
  resources :line_items, only: [:create, :destroy]
  resources :reviews, only: [:create]
  resources :users
  resources :friendships
  resources :password_resets

  resources :forgot_passwords, only: [:create]

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'reset_password_confirmation', to: 'forgot_passwords#confirm'

  get 'expired_token', to: 'password_resets#expired_token'
  get 'password_reset/:token', to: 'password_resets#new', as: 'new_password_reset'
  get 'update_account', to: 'users#update'

  resources :invitations

  resources :videos do
    resources :reviews
  end
  resources :videos do
	get 'search', :on => :collection
   end
end
