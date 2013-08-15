Robbit::Application.routes.draw do
	root :to => "users#index"
  resource :session, :only => [:new, :create, :destroy]
  resources :users
end