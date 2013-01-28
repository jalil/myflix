Myflix::Application.routes.draw do
  get "videos/index"
  resources :videos
  get 'home',  :to=> "videos#index"
  get 'ui(/:action)', controller: 'ui'
end
