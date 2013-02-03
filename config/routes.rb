Myflix::Application.routes.draw do
  get 'register', :to =>"users#new",  :as =>:register
  get 'login', :to =>"sessions#new", :as => :login
  post 'login', :to => 'sessions#create'
  get 'logout', :to => 'sessions#destroy', as:  'logout'

  get "videos/index"
  get 'home',  :to=> "videos#index", :as => "home"
 # get "register",  :to => "pages#register", :as => 'register'
  #get "login",  :to => "pages#sign_in", :as => 'login'
  get 'ui(/:action)', controller: 'ui'

  root :to => "pages#front"

  resources :pages
  resources :users

  resources :videos do
	get 'search', :on => :collection
   end
end
