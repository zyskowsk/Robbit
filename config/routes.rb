Robbit::Application.routes.draw do
	root :to => "subs#front_page"
  resource :session, :only => [:new, :create, :destroy]
  resources :users
  resources :subs
  resources :links do
		resources :comments, :only => [:new, :delete, :create, :edit]
  end
end