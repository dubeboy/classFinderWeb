class Api::V1::SessionsController < ApplicationController
  # todo create a different path for the system sign in
  #this method handles signup respect it
#   fixme: REPEATEDish CODE
  swagger_controller :users, "Sessions for logging in"


  def create
    if params[:email] and params[:password]
      @status = false #true if the user is successfull else not
      @user = User.authenticate(params[:email], params[:password])
      if @user
        @jwt_token = create_custom_token(params[:email])
        session[:user_id] = @user.id
        @user.fcm_token = params[:fcm_token]
        @user.save
        @status = true
      else
          #todo: redundant keep safe for now
        @status = false
      end
    else #end normal sign in if     #Google dwag
      @user = User.from_omniauth(env["omniauth.auth"])    #Google USER HELLOOOOO
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
