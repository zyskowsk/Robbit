Robbit::Application.routes.draw do
	root :to => "subs#front_page"
  resource :session, :only => [:new, :create, :destroy]
  resources :users
  resources :subs
  resources :links
end