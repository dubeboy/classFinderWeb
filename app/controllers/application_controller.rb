class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :
  require 'venue_finder_lib'
  helper_method :current_user
  helper_method :get_free
  helper_method :notify_user

  BRAND_NAME = 'Classfinder++'.freeze

  def meta_title(title)
    [title, BRAND_NAME].reject(&:empty?).join(' | ')
  end

  private

  def current_user
    #fixme please try  and catch when User.find(session[:user_id]) is nil

    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      session.delete(:user_id)
      session[:user_id] = nil
    end
  end

  def authenticate_user!
    if current_user.nil?
      flash[:danger] = 'In order to use this feature please sign up.'
      redirect_to '/hosts'
      return false
    else
      return true
    end

  end

=begin
    token - is an array with of reg ids
    options - is hash with data to be sebt to the client
=end
  def notify_user(reg_ids = [], options = {})
    fcm = FCM.new("AIzaSyCl5ylWRVZU3ci8DC3if1KOxZ0zN2oS1aY")
    registration_ids= reg_ids  # an array of one or more client registration tokens
    # options = {data: {score: "123"}, collapse_key: "updated_score"}
    response = fcm.send(registration_ids, options)
  end
end
