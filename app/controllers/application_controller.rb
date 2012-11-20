class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def logged_in?
    !!current_user
  end

  before_filter :require_login
 
  private

  def require_login
    unless logged_in?
      @no_login = "You must be logged"
      redirect_to '/sessions/new'
    end
  end

end
