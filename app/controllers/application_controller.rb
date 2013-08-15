class ApplicationController < ActionController::Base
  protect_from_forgery

  def login(user)
  	user.shuffle_session_key
  	session[:session_key] = user.session_key
    user.save
  	redirect_to user_url(user)
  end

  def logout(user)
  	user.shuffle_session_key!
  	session[:session_key] = nil
  end

  def notices
  	flash[:notices] ||= []
  end
end
