Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      post "search", to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  resources :users, only: [:create, :show]
  get 'register', to: "users#new"
  get 'register/:token', to: 'users#new_with_invitation', as: 'register_with_token'

  resources :sessions, only: [:create]
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"

  get 'my_queue', to: "queue_items#index"
  post 'update_queue', to: "queue_items#update_queue"
  resources "queue_items", only: [:create, :destroy]

  get 'people', to: 'relationships#index'
  resources :relationships, only: [:destroy, :create]

  get 'forgot_password', to: "forgot_passwords#new"
  resources :forgot_passwords, only: [:create]

  get 'reset_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'password_resets#expired_token'
  get 'password_reset/:token', to: 'password_resets#new', as: 'new_password_reset'
  resources :password_resets, only: [:create, :update]
  resources :invitations, only: [:new, :create]

  root to: 'pages#front'
end
