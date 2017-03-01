class Api::V1::UsersController < ApplicationController

 def create
    @status = false
    if (params[:token]) 
        if User.find_by_email(params[:email]).nil? #if there is no user
            user = User.new(name: params[:name], email: params[:email],
                                                              provider: 'google_oauth2', uid: params[:token])
            user.runner = params[:is_runner]
            @status = user.save(:validate => false) #because no password!
            if(user.save(:validate => false)) 
              @status = true
              @u = User.find_by_email(params[:email])
            end
        else 
            @status = true
            @u = User.find_by_email(params[:email])
        end
    else 
      if User.find_by_email(params[:email]).nil? #if there is no user
         user = User.new(name: params[:name], password: params[:password],
                                             email: params[:email], password_confirmation: params[:password])
       user.runner = params[:is_runner]
       @status = user.save
       @u = User.find_by_email(params[:email])
      else
         @status = false
      end
    end 
    respond_to do |f|
         f.json
    end
  end

    #this shoukd returns the runner or host info
    def show
    @user = User.find(params[:id])
    booking_type = params['booking_type']

    if @user.verified?
      if @user.bank_details.nil? and @user
        flash[:warning] = "Please add your bank details."
      end
      if @user and params['cat']
        # do something like TODO: where('host_id = ?', @user.id ) to avoid sql injection
        trans_by_this_user = Transaction.where("host_id = '#{@user.id}'").reverse_order #array of this hosts trasctns
        if params['cat'] == '0'
          @acs = @user.accommodations
        elsif params['cat'] == '1' #for available accommodations
          @trans = trans_by_this_user.collect { |t| t unless t.paid? }
        elsif params['cat'] == '3' #where the student has confirmed, paid by students
          @trans = trans_by_this_user.collect { |t| t if t.std_confirm? }
        elsif params['cat'] == '4' #upcoming waiting confirmation
          @trans = trans_by_this_user.collect { |t| t if t.paid }
        end
        @acs = @user.accommodations if @user
      end
    elsif @user.runner? and params['run'] #runner actions
      trans_by_this_user = Transaction.where("runner_id = '#{@user.id}'").reverse_order
      if params['run'] == '1' #for all students who are intrested
        @trans = trans_by_this_user.select { |t| t unless t.std_confirm? } # this should be selected based on time
      elsif params['run'] == '2' #for all students who are say they have paid for the res
        @trans = trans_by_this_user.select { |t| t if t.std_confirm? } #this is all paid but user id is this one
      elsif params['run'] == '3' #where the student has confirmed, paid by students
        @trans = trans_by_this_user.select { |t| t if t.paid? } #this is all the upcoming one
      end
    end
    @trans
    respond_to do |f|
         f.json
        end
    end

     def panel
    user = User.find(params[:id])
    @trans_by_this_user = Transaction.where("user_id = '#{user.id}'") #array of this hosts trasctns
    # @acs = Accommodation.find(trans_by_this_user.collect { |t| t.accomodation_id }) #just getting the users accomodations
     respond_to do |f|
         f.json
      end 
  end

end
