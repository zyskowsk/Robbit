Robbit::Application.routes.draw do
	root :to => "subs#front_page"
  resource :session, :only => [:new, :create, :destroy]
  resources :users
  resources :subs
  resources :links do
  	post "/upvote" => "links#upvote"
  	post "/downvote" => "links#downvote"
		resources :comments, :only => [:new, :delete, :create, :edit]
  end


end