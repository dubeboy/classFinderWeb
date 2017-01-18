class Api::V1::SessionsController < ApplicationController
  # todo create a different path for the system sign in
  #this method handles signup respect it
#   fixme: REPEATEDish CODE
  def create
    if params[:email] and params[:password]
        @status = false #true if the user is successfull else not
      @user = User.authenticate(params[:email], params[:password])
      if @user
        session[:user_id] = @user.id
        @status = true
      else
          #todo: redundant keep safe for now
        @status = false
      end
    else #end normal sign in if
      @user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = @user.id
      begin
        redirect_to :back
      rescue ActionController::RedirectBackError
        redirect_to root_path
      end
    end
      respond_to :json
  end

def destroy
  session.delete(:user_id)

  session[:user_id] = nil
  redirect_to root_url, :notice => "Logged out!"
end
end
