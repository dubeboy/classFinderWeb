class UsersController < ApplicationController

  before_action :authorised_user , only: [:edit, :update ]
def new
  @user = User.new
end
def create
  @user = User.new(user_params)
  if @user.save
     session[:user_id] = @user.id
    redirect_to root_url, notice: 'Signed up!'
  else
    render 'new'
  end
end

def show
  @user = User.find(params[:id])
end

def edit
  @user = User.find(params[:id])
end

def update
  @user = User.find(params[:id])
  if @user.update_attributes(user_params)
    flash[:success] = 'Successfully edited your profile'
     #sign_in @user
    redirect_to @user
  else
    flash[:error] = 'please try again'
    render 'edit'
  end
end

  private
    def user_params
     # params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
      params.require(:user).permit!
    end

  def authorised_user
    puts current_user
    if current_user and current_user == User.find(params[:id])
      flash[:danger] = 'you now about to edit your account'
      true
    else
      flash[:danger] = 'You are not allowed to edit an account that is not yours'
      redirect_to root_path
      false
    end

  end
end
