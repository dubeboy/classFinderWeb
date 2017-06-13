class Api::V1::AccommodationsController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show, :search]
  # before_action :require_api_key!, except: [:index, :show, :search] //Todo NB in the future man
  #use that before_action to set the @user when finding first

  def index #fixme
    @acs = Accommodation.all.paginate(page: params[:page],
                                    per_page: 20).order(created_at: :desc)
    respond_to do |format|
      format.json
      format.html
      format.js
    end
  end

  def new
    @ac = Accommodation.new
  end

  #todo only verified users can create accomodations
  def create
    @status = false
    ac = Accommodation.new(price: params[:price], room_type: params[:room_type],
                             description: params[:description] )
    ac.user = User.find(params[:user_id])
    if params[:images]
      if ac.save
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
  end

  def destroy
    @acs = Accommodation.find(params[:id])
    t = Transaction.where('host_id = ? and accomodation_id = ?', current_user.id, @acs.id).destroy_all
    @acs.destroy
    redirect_to accommodations_path, notice: 'Accommodation deleted.'
  end

  # ==========under the hood dont look if you can`t handle=========

  def search

    @Inst = ['UJ ', 'Wits', 'Other']

    if params[:price_to] == '0'
      x = ""
    else
        x = params[:price_to]
    end
    #fixme term is out for now man
    @acs = Accommodation.search(params[:name], params[:room_type],
                                price_from: params[:price_from],
                                price_to: x, precise_loc: params[:auck_location])
               .paginate(:per_page => 6, :page => params[:page])

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
    #pron to Sql injection
    #booking type information 1 is secure and 0 is view
    #todo make sure that a person can not secure a room twice extract common stuff
    @k = false
    if booking_type == "1"
      #todo check this man put in model
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").where("booking_type = 't' ").count == 0
        t = Transaction.new(user_id: student_id, accomodation_id: advert_id,
                            host_id: host_id, booking_type: 1, paid: 0)
        ad.is_secured = true
        ad.save! #todo put this in the models some how #before_action?
        @k = t.save!
      end

    elsif booking_type == "0" #booking type = 0 = view accomodation
      #find runner and set runner
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").where("booking_type = 'f' ").count == 0
        time = params['time'] # to 8:00
        month = params['month']

        av_r = User.all.collect { |r| available(r, time) if (r.runner? and r.run_location == ad.location) } #todo should runner location be defined for a accommodation house only?
        puts '------------------------------------902323'
        puts av_r.class
        puts '------------------------------------45454'
        available_runners = av_r.compact
        puts available_runners
        puts available_runners.class
        puts available_runners.length
        puts '------------------------------------902323'
        if available_runners.length != 0
          puts '----------900e-----'
          rand_i = available_runners.length == 1 ? 0 : rand(0..(available_runners.length-1)) #fixme what!!!!  #todo improve runner assignment
          runner = available_runners[rand_i] #fixme say whaaaaa!!!
          runner_id = runner.id
          puts
          puts '---------ewe434------'
          t = Transaction.new(user_id: student_id, accomodation_id: advert_id,
                              runner_id: runner_id, booking_type: 0, paid: 0,
                              time: time, month: month, std_confirm: false, host_id: ad.user.id)
          @k = t.save!
        else
          @k = false
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
