Myflix::Application.routes.draw do

  get 'register', :to =>"users#new"
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

  resources :videos do
    resources :reviews
  end
  resources :videos do
	get 'search', :on => :collection
   end
end
