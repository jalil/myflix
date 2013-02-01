Myflix::Application.routes.draw do
  get "videos/index"
  get 'home',  :to=> "videos#index", :as => "home"
  get 'ui(/:action)', controller: 'ui'

  root :to => "videos#index"
  resources :videos do  
	get 'search', :on => :collection
   end
end
