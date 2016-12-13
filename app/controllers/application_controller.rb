class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :


  helper_method :current_user

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user!
    if current_user.nil?
      flash[:danger] = 'You have successfully signed in, Lets get selling!!! or buying...'
      redirect_to '/auth/google_oauth2'
      return false
    else
      return true
    end

  end




end
