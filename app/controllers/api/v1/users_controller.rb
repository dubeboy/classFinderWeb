class Api::V1::UsersController < ApplicationController
  swagger_controller :users, "User Controller"

  def check_if_user_exits
    h = User.find_by_email(params[:email])
    if h
      @exits = true
      @u = h
      return
    end
    @exits = false
  end

  def create
    @status = false
    @jwt_token = create_custom_token(params[:email])
    if params[:token] #Google Token
      if User.find_by_email(params[:email]).nil? #if there is no user
        user = User.new(name: params[:name],
                        email: params[:email],
                        provider: 'google_oauth2',
                        fcm_token: params[:fcm_token],
                        uid: params[:token])
        user.runner = params[:is_runner]
        @status = user.save(:validate => false) #because no password!
        if user.save(:validate => false)
          @status = true
          @u = User.find_by_email(params[:email])
        else
          @status = false #not requred i think
        end
      else
        @status = true
        @u = User.find_by_email(params[:email])
      end # end google signin
    else #normal signup yoh!!!!!!!
      if User.find_by_email(params[:email]).nil? #if there is no user
        user = User.new(
            name: params[:name],
            password: params[:password],
            email: params[:email],
            fcm_token: params[:fcm_token],
            password_confirmation: params[:password],
            contacts: params[:phone])

        user.runner = params[:is_host]
        user.host =
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


  def notify_host
    host = User.find(params[:host_id])
    sender = User.find(params[:sender_id])
    room_id = params[:room_id]
    is_open_by_host = params[:is_open_by_host]

    NotifyWorker.perform_async(host.fcm_token,
                               'A Classfinder possible tenent would like to ask you about a particular accommodation',
                               'Cf possible tenent',
                               data = {room_id: room_id,
                                       room_location: "",
                                       sender_email: sender.email,
                                       sender_id: sender.id,
                                       is_open_by_host: is_open_by_host,
                                       host_id: host.id})
  end


  def send_sms
    phone = params[:phone_number]
    user_id = params[:user_id]
    u = User.find(user_id)

    # todo: what to write
    # SendSmsJob.perform_later(phone, "#{u.name} is inviting you to classfinder, to advertise your accommodation for a targeted audience, like: classfinderpp.com/api/v1/refs?token=#{u.token}")
    SmsWorker.perform_async(phone, "#{u.name} is inviting you to classfinder, to advertise your accommodation for a targeted audience, accept by clicking http://classfinderpp.com/api/v1/refs?token=#{u.token}")
    respond_to do |f|
      f.json
    end
  end


  def save_fcm_token
    fcm_token = params[:fcm_token]
    u = User.find_by_email(params[:email])
    u.fcm_token = fcm_token
    @status = u.save
    respond_to do |f|
      f.json
    end
  end


  def get_user
    @user = User.find(params[:user_id])
    respond_to do |f|
      f.json
    end
  end


  def set_user_token
    firebase_cloud_msg_token = params[:fcm_token]
    u = User.find(params[:email])
    u.fcm_token = firebase_cloud_msg_token
    u.save

    respond_to do |res|
      res.json
    end
  end

  #this shoukd returns the runner or host info
  def show
    @user = User.find(params[:id])
    booking_type = params['booking_type']

    if @user.verified?
      if @user.bank_details.nil? and @user
        flash[:warning] = 'Please add your bank details.'
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
      trans_by_this_user = Transaction.where("runner_id = ?", @user.id).reverse_order
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


  def get_host_info
    # student name
    # time to view
    # location as well
    host_id = params[:host_user_id]
    @t = Transaction.where("host_id= ?", host_id).paginate(page: params[:page],
                                                           per_page: 20).order(created_at: :desc)
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
