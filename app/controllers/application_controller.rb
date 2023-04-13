class ApplicationController < ActionController::Base
  def index
    redirect_to articles_path if is_logged_in?
  end

  helper_method :current_user, :is_logged_in?

  def current_user
    @currentUser ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_logged_in?
    !!current_user
  end
end
