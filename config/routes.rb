Myflix::Application.routes.draw do
  resources :parties


  resources :todos


  get 'register', :to =>"users#new"
  get 'login', :to =>"sessions#new"
  post 'login', :to => 'sessions#create'
  get 'logout', :to => 'sessions#destroy'

  get "videos/index"
  get 'home',  :to=> "videos#index"
  get 'my_queue',  :to=> "line_items#index"
  post 'update_lines',  :to=> "line_items#update_lines"
  get 'ui(/:action)', controller: 'ui'

  root :to => "pages#front"

  resources :pages
  resources :line_items, only: [:create, :destroy]
  resources :reviews, only: [:create]
  resources :users

  resources :videos do
    resources :reviews
  end
  resources :videos do
	get 'search', :on => :collection
   end
end
