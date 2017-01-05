class SessionsController < ApplicationController
  def new
  end

  # todo create a different path for the system sign in
  #this method handles signup respect it
  def create
    if params[:email] and params[:password]

      user = User.authenticate(params[:email], params[:password])
      if user
        session[:user_id] = user.id
        redirect_to root_url, :notice => "Logged in!"
      else
        flash.now.alert = "Invalid email or password"
        render "new"
      end
    else

      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to :back
    end
  end

def destroy
  session.delete(:user_id)

  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end
end
