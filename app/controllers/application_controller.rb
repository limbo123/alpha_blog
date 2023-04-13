class ApplicationController < ActionController::Base
  def index
    redirect_to articles_path if is_logged_in?
  end

  helper_method :current_user, :is_logged_in?, :require_user

  def current_user
    @currentUser ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_logged_in?
    !!current_user
  end

  def require_user
    if !is_logged_in?
      flash[:alert] = "You are not able to do this kind of operations since you aren't logged in"
      redirect_to login_path
    end
  end
end
