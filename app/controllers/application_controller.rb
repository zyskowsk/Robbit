class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in? 

  def current_user
    User.find_by_session_key(session[:session_key])
  end

  def logged_in?
    !!current_user
  end

  def login(user)
  	user.shuffle_session_key!
  	session[:session_key] = user.session_key
  	redirect_to root_url
  end

  def logout(user)
  	user.shuffle_session_key!
  	session[:session_key] = nil
    redirect_to root_url
  end

  def notices
  	flash[:notices] ||= []
  end

  def now_notices
    flash.now[:notices] ||= []
  end

  def is_logged_in?
    unless logged_in?
      notices << "Please login to do that"
      redirect_to :back
    end
  end

  def vote(value)
    @vote = UserVote.new(:user_id => current_user.id,
                         :link_id => params[:link_id],
                         :value => value)
    if @vote.save
      notices << "Thanks for voting!"
      redirect_to :back
    else
      notices << "You already voted!"
      redirect_to :back
    end
  end
end
