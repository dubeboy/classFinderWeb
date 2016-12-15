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
  # byebug
  #todo sql  fix the reds
  @user = User.find(params[:id])
  booking_type = params['booking_type']
  #checking if  this user is the host
  # if @user.verified == 1 todo is it okay


  if params['cat']
    trans_by_this_user = Transaction.where("host_id = '#{@user.id}'") #array of this hosts trasctns

    unpaid_transactions = trans_by_this_user.collect {|t| t unless t.paid?}

    if params['cat'] == '1' #for open accommodations
      @acs = Accommodation.find(unpaid_transactions.collect {|t| t.accomodation_id})
    elsif params['cat'] == 2 #for objects that are upcoming for viewing
      @acs = Accommodation.find(trans_by_this_user.collect {|t|  t if t.booking_type == 0 })
    elsif params['cat'] == 3 #where the student has confirmed
      @acs = Accommodation.find(trans_by_this_user.collect {|t|  t if t.std_confirm? })
    elsif params['cat'] == 4
      @acs = Accommodation.find(trans_by_this_user.collect {|t|  t if t.std_confirm? })
    else
      @acs = Accommodation.find(unpaid_transactions.collect {|t| t.accomodation_id})
    end
  end

end

  def panel
    @user = User.find(params[:id])
    trans_by_this_user = Transaction.where("host_id = '#{@user.id}'") #array of this hosts trasctns
    @acs = Accommodation.find(trans_by_this_user.collect {|t| t.accomodation_id })  #just getting the users accomodations
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
