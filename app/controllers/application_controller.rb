class ApplicationController < ActionController::Base
  protect_from_forgery

  def notices
  	flash[:notices] ||= []
  end

  def notices_now
  	flash.now[:notices] ||= []
  end
  
end
