class Api::V1::AccommodationsController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show, :search]
  # before_action :require_api_key!, except: [:index, :show, :search] //Todo NB in the future man
  #use that before_action to set the @user when finding first


  def init
    Rails.logger("Hello there")
  end


  def index #fixme
    @acs = Accommodation.all.paginate(page: params[:page],
                                      per_page: 20).order(created_at: :desc)
    respond_to do |format|
      format.json
    end
  end

  def new
    @ac = Accommodation.new
  end

  def share_ref
    token = params[:tk]
    accom_id = params[:accom_id]
    @status = false

    u = User.find_by_token(token)
    unless accom_id.nil? #if not nil?
      @accom = Accommodation.find(accom_id)
      user_share = UserAccommodationShare.find_by_user_token(token)
      # byebug
      if user_share.nil? && !@accom.nil?
        @status = UserAccommodationShare.new(accom_id: @accom.id, user_token: token).save
        NotifyWorker.perform_async(@accom.user.fcm_token, '+1 on your link click', 'Classfinder shares', data={}) #todo: notify user when link is clicked
      else
        user_share.count = user_share.count + 1
        user_share.save! unless @accom.nil?
        NotifyWorker.perform_async(@accom.user.fcm_token, "#{ user_share.count -1 } +1 on your link click", 'Classfinder shares', data={}) #todo: notify user when link is clicked
        @status = true
      end
      # NotifyWorker.perform_async(user_share.fcm_token, 'someone is searching for an accommodation like yours, click to see them', 'Classfinder Search Rader')
    else #this is for when invinting an accommodation owner todo: this should in its own controller
      @status = true
      @msg = 'redirect to sign in'
    end

    respond_to do |format|
      format.json
    end

  end

  #todo only verified users can create accomodations
  def create
    @status = false
    ac = Accommodation.new(
        price: params[:price],
        deposit: params[:deposit],
        room_type: params[:room_type],
        description: params[:description]
    )
    ac.house = House.find(params[:house_id])
    ac.user = User.find(params[:user_id])
    if params[:images]
      if ac.save!
        params[:images].each { |image|
          puts '######################################'
          puts image
          puts '######################################'
          ac.pictures.create(image: image)
        }
        @status = true
      end
      # redirect_to @ac  todo: should look into this man
    else
      @status = false
    end
    # byebug #end the bugs : yeyyy TODO: show stoper #bye bug
  end

  def edit
    @ac = Accommodation.find(params[:id])
  end

  def update
    @ac = Accommodation.find(params[:id])
    @ac.update(acc_params)
    redirect_to accommodation_path(@ac)
  end

  def show
    @ac = Accommodation.find(params[:id])
    views = @ac.views
    views += 1 if @ac.user != current_user
    @ac.update_attribute(:views, views) if @ac.user != current_user
    respond_to do |format|
      format.json
    end
  end

  def destroy
    @acs = Accommodation.find(params[:id])
    t = Transaction.where('host_id = ? and accomodation_id = ?', current_user.id, @acs.id).destroy_all
    @acs.destroy
    redirect_to accommodations_path, notice: 'Accommodation deleted.'
  end

  def search
    puts '-------------------------------------------------'
    nsfas = params[:nsfas]
    location = params[:location] #brixton , auckland park, johannesburg #can be null yoh null? no nearby place
    near_to = params[:near_to]
    searcher_id = params[:searcher_id]
    sender = nil
    room = params[:room_type]
    puts 'starting man!!!#########################'
    puts location
    puts nsfas
    puts near_to
    puts searcher_id
    puts room
    puts 'starting man!!!#########################'
    if searcher_id.to_i > 0
      puts 'in here'
      sender = User.find(searcher_id)
    end
    #todo: for the search we should have anonymous chat
    puts 'GOING  To pRICE MAN ############################w#####'
    puts sender.name

    if params[:price_to] == '0' #if a user did not add ending price then the price will be 0
      x = ""
    else
      x = params[:price_to]
    end
    puts 'eND  To pRICE MAN ############################w#####'
    unless location.nil?
      q = 'location = ? or city = ?'
      @house = House.where(q, location, location).paginate(:per_page => 13, :page => params[:page]) unless location.empty?
    end
    puts 'eND OF HOUSE  To pRICE MAN ############################w#####'
    unless near_to.nil?
      @house = @house.each { |k| k.near_tos.select { |n| k if (n.location == near_to) } } unless near_to.empty?
    end
    @house = @house.select { |h| h if (h.nsfas) } unless (nsfas.nil? || nsfas.empty?)
    puts 'sELECTED HOUSE WITH nsfas  To pRICE MAN ############################w#####'

    puts "the number of houses is #{@house.count}"
    @acs = Array.new
    # byebug
    @house.each do |h|
      puts 'the house'
      h.accommodations.each do |a|
        b = a.search_it(params[:room_type],
                        price_from: params[:price_from],
                        price_to: x).paginate(:per_page => 24, :page => params[:page]) # if so happens that this house 24 rooms
        if b.size > 0
          b.each do |ac|
            @acs.append(ac)
            puts 'the house` accommodation`'
            if sender.nil?
              puts 'sender is nil man what! '
            else
              puts 'in here man)))))))))))'
              NotifyWorker.perform_async(ac.user.fcm_token,
                                         "#{sender.name} is searching for an accommodation like yours, click to chat to them",
                                         'Classfinder Search Rader',
                                         data = {
                                             sender_email: sender.email,
                                             sender_id: sender.id,
                                             is_open_by_host: "true",
                                             host_id: ac.user.id})

            end
          end

          #todo: abilty for them to initiate conversations
        end
        #loop
        # byebug

      end
    end
    respond_to do |format|
      format.json
    end
  end

  def secure_room
    #todo check if the user is actually not a host
    host_id = params['host_id']
    student_id = params['std_id']
    booking_type = params['booking_type']
    advert_id = params['id']
    ad = Accommodation.find(advert_id)
    time = params[:time]
    month = params[:month]
    #pron to Sql injection
    #booking type information 1 is secure and 0 is view
    #todo make sure that a person can not secure a room twice extract common stuff
    @k = false
    if booking_type == '1'
      #todo check this man put in model
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").where("booking_type = 't' ").count == 0
        t = Transaction.new(user_id: student_id, accomodation_id: advert_id,
                            host_id: host_id, booking_type: 1, paid: 0)
        ad.is_secured = true
        ad.save! #todo put this in the models some how #before_action?
        @k = t.save
      end

    elsif booking_type == "0" #booking type = 0 = view accomodation
      #find runner and set runner
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").where("booking_type = 'f' ").count == 0
        t = Transaction.new(user_id: student_id,
                            accomodation_id: advert_id,
                            booking_type: 0, #false uhm..... why dude!
                            paid: 0, #false
                            time: time,
                            month: month,
                            std_confirm: false,
                            host_id: ad.user.id)
        @k = t.save

        student = User.find(student_id)
        host = User.find(host_id)

        if @k
          NotifyWorker.perform_async(host.fcm_token,
                                     "#{student.name} would like to come a view one of your rooms at #{time} on #{month},click to view more details'",
                                     'Classfinder++', data={for_host: 'yes'})
          NotifyWorker.perform_async(student.fcm_token,
                                     "you have successfully booked to view the room, you will here from the accommodation owner soon'",
                                     'Classfinder Booking Radar', data={for_host: 'no'})
        end
      end
    end

    respond_to do |format|
      format.json
    end
  end

  #please clean up these methods man
  def pay
    @ac = nil
    ac_id = params[:id]
    student_id = params[:student_id]
    the_trans = Transaction.find(params[:trans_id])
    unless the_trans.nil?
      if the_trans.paid?
        the_trans.paid = false
      else
        the_trans.paid = true
      end
      the_trans.save
      format.json
    end
    respond_to do |format|
      format.js
    end
  end


  def deposit

    # accom = Accommodation.find(params[:id])
    # am = accom.deposit * 100 # the deposit because stripe works in cents
    depo = params[:deposit].to_i * 100
    @amount = depo
    @msg = ""
    @status = false
    student = User.find_by_email(params[:email])
    accommodation = Accommodation.find(params[:id])
    host = accommodation.user


    # todo: should check if the transactin exists before we create another one

    customer = Stripe::Customer.create(
        :email => student.email,
        :source => params[:stripeToken]
    )

    host_customer = Stripe::Customer.create(
        :email => host.email,
        :source => params[:hostStripeToken]
    )

    #the we take 2 percent of what ever the deposit is and the rest goes to the owner
    charge = Stripe::Charge.create(
        :customer => customer.id,
        :amount => @amount,
        :description => "#{@amount} deposit for accommodation id: #{accommodation.id}
                        and user id #{student.id}: (#{student.name}) ",
        :currency => 'zar',
        :destination => {
            :amount => (@amount - (@amount * 0.2)).to_i,
            :account => host_customer.id,
        }

    )
    @status = true

    t = Transaction.new(user_id: student.id,
                        accomodation_id: accommodation.id,
                        host_id: host.id,
                        paid: true)
    t.save
    # notify the owners
    # notify_user(reg_ids= [student.fcm_token],
    #             options = {from: "Classfinder++",
    #                        data: "congratulations you have just secured the accommodation",
    #                        accommodation_id: accommodation.id })
    # notify_user(reg_ids= [host.fcm_token],
    #             options = {from: "Classfinder++",
    #                     data: "congratulations you have a new tenet #{student.name}, the paid R#{@amount}",
    #                     accommodation_id: accommodation.id })

    NotifyWorker.perform_async(student.fcm_token, 'congratulations you have just secured the accommodation', 'Classfinder Deposit Rader')
    NotifyWorker.perform_async(host.fcm_token, "congratulations you have a new tenet #{student.name}, the paid R#{@amount}", 'Classfinder Deposit Rader')

    respond_to do |format|
      format.json
    end

  rescue Stripe::CardError => e
    @msg = e.message
    @status = false

  end


  #student transaction
  def student_pay
    @ac = nil
    the_trans = Transaction.find(params[:trans_id])
    unless the_trans.nil?
      @ac = the_trans
      the_trans.std_confirm = true
      the_trans.save
    end
    respond_to do |format|
      format.js
    end
    redirect_to :back, notice: 'Notified accommodation host keep up the good work!'
  end


  def go_ahead
    @ac = nil
    ac_id = params[:id]
    student_id = params[:student_id]
    the_trans = Transaction.find(params[:trans_id])
    unless the_trans.nil?
      the_trans.go_ahead = true
      student = User.find(student_id)
      host = User.find(ac_id)
      acc = Accommodation.find(the_trans.accomodation_id)

      the_trans.message = "Dear #{student.name.capitalize} we at #{host.name.capitalize} have
                           confirmed that we have received your request to secure the
                           room. You can go
                           ahead and deposit #{acc.price} using banking details
                           attached below \n #{host.bank_details} \n your reference number: #{student.token}"
      the_trans.save
    end
    redirect_to :back, notice: "Given Go a head to student"
  end

  #formula
  # this should enable a user to set the paid on or off but this a way of removing a an Item
  # def toggle_paid
  #   @ac = nil
  #   ac_id = params[:id]
  #   student_id = params[:student_id]
  #   the_trans = Transaction.find(params[:trans_id])
  #   unless the_trans.nil?
  #
  #     if the_trans.paid?
  #       the_trans.paid = false
  #     else
  #       the_trans.paid = true
  #     end
  #     the_trans.save
  #   end
  #   redirect :back
  # end

  def toggle_room_view
    the_trans = Transaction.find(params[:trans_id])
    unless the_trans.nil?
      if the_trans.std_confirm?
        the_trans.std_confirm = false
      else
        the_trans.std_confirm = true
      end
      the_trans.save
    end
    redirect :back
  end


  private
  def acc_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:accommodation).permit!
  end

  # def make_two_digits(digit)
  #   digit.length < 2 ? "0#{digit}" : digit
  # end
  #todo does this does what it is supposed to do
  def available(r, time) #call the time slot table to this runner
    runner_times = r.time_slots.all.collect { |rt| rt.time }
    puts '===========================9'
    puts runner_times
    puts time
    puts '===========================9'
    runner_times.each { |rt|
      puts 'rt'
      puts rt == time
      if rt == time
        return r
      end
    }
    return nil
  end
end
