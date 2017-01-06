class UsersController < ApplicationController

  before_action :authenticate_user!, only: [:edit, :update, :panel]

  def new
    @user = User.new
  end

  def create
    @user = User.find_or_initialize_by(email: params[:email])
    if @user.update_attributes(user_params)
      session[:user_id] = @user.id
      redirect_to root_url, notice: 'Signed up!'
    else
      render 'new'
    end
  end

  #Dirty
  def show
    # byebug
    #todo sql  fix the reds
    @user = User.find(params[:id])
    booking_type = params['booking_type']
    #checking if  this user is the host
    # if @user.verified == 1 todo is it okay
    #todo fix the security issue of host van view other host stuff
    #todo benchmark this for performace test

    if @user.verified?
      if @user.bank_details.nil? and @user == current_user
        flash[:warning] = "Please add your bank details."
      end
      if @user == current_user and params['cat']
        #we want users to be able to see all that users accommodation todo - should paginate
        trans_by_this_user = Transaction.where("host_id = '#{@user.id}'").reverse_order #array of this hosts trasctns
        # unpaid_transactions = trans_by_this_user.collect { |t| t unless t.paid? }
        # @acs = Accommodation.find(unpaid_transactions.collect { |t| t.accomodation_id })
        if params['cat'] == '0'
          @acs = current_user.accommodations
        elsif params['cat'] == '1' #for available accommodations
          # unpaid_transactions = trans_by_this_user.collect { |t| t unless t.paid? }
          # @acs = Accommodation.find(unpaid_transactions.collect { |t| t.accomodation_id })
          @trans = trans_by_this_user.collect { |t| t unless t.paid? }
          #   fixme skipped because there is no other booking type
          # elsif params['cat'] == '2' #for objects that are upcoming for viewing
          #   #todo check this if its real please or should it (if t.booking_type)
          #   @trans = trans_by_this_user.collect { |t| t unless t.booking_type? } #this should be if booking type == viewing
        elsif params['cat'] == '3' #where the student has confirmed, paid by students
          @trans = trans_by_this_user.collect { |t| t if t.std_confirm? }
        elsif params['cat'] == '4' #upcoming waiting confirmation
          @trans = trans_by_this_user.collect { |t| t if t.paid }
        end
        @acs = current_user.accommodations if @current_user
      end
    elsif @user.runner? and params['run'] #runner actions
      puts 'in Here man-----------------------------------------------------------'
      trans_by_this_user = Transaction.where("runner_id = '#{@user.id}'").reverse_order
      if params['run'] == '1' #for open accommodations
        @trans = trans_by_this_user.collect { |t| t unless t.std_confirm? } # this should be selected based on time
      elsif params['run'] == '2' #for objects that are upcoming for viewing
        @trans = trans_by_this_user.collect { |t| t if t.std_confirm? } #this is all paid but user id is this one
      elsif params['run'] == '3' #where the student has confirmed, paid by students
        @trans = trans_by_this_user.collect { |t| t if t.paid? } #this is all the upcoming one
      end
    end
    @trans
  end

=begin
  this returns a transaction as all the other trasaction functions(t), lol
=end
  def panel
    @user = current_user
    @trans_by_this_user = Transaction.where("user_id = '#{@user.id}'") #array of this hosts trasctns
    # @acs = Accommodation.find(trans_by_this_user.collect { |t| t.accomodation_id }) #just getting the users accomodations
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
