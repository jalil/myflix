Myflix::Application.routes.draw do
  get 'register', :to =>"users#new",  :as =>:register
  get 'login', :to =>"sessions#new", :as => :login
  post 'login', :to => 'sessions#create'
  get 'logout', :to => 'sessions#destroy', as:  'logout'

  get "videos/index"
  get 'home',  :to=> "videos#index", :as => "home"
  get 'ui(/:action)', controller: 'ui'

  root :to => "pages#front"

  resources :pages
  #resources :reviews, only: [:create]
  resources :users

  resources :videos do
    resource :reviews
  end
  resources :videos do
	get 'search', :on => :collection
   end
end
