class ApplicationController < ActionController::Base
  protect_from_forgery

  def login(user)
  	user.shuffle_session_key!
  	session[:session_key] = user.session_key
  end

  def logout(user)
  	user.shuffle_session_key!
  	session[:session_key] = nil
  end

  def notices
  	flash[:notices] ||= []
  end

  def notices_now
  	flash.now[:notices] ||= []
  end
  

end
