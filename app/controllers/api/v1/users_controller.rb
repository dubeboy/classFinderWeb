class Api::V1::UsersController < ApplicationController
    #this shoukd returns the runner or host info
    def show
    @user = User.find(params[:id])
    booking_type = params['booking_type']

    if @user.verified?
      if @user.bank_details.nil? and @user
        flash[:warning] = "Please add your bank details."
      end
      if @user and params['cat']
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
      if params['run'] == '1' #for open accommodations
        @trans = trans_by_this_user.select { |t| t unless t.std_confirm? } # this should be selected based on time
      elsif params['run'] == '2' #for objects that are upcoming for viewing
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
end
