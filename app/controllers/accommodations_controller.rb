class AccommodationsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show, :search]

  def index #fixme
    @acs = Accommodation.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    @locations = ['Auckland Park', 'Braam', 'Soweto']
    @Inst = ['UJ', 'Wits', 'Other']
  end

  def new
    @ac = Accommodation.new
  end

  #todo only verified users can create accomodations
  def create
    @ac = Accommodation.new(acc_params)
    @ac.user = current_user
    if params[:images]
      if @ac.save
        params[:images].each { |image|
          @ac.pictures.create(image: image)
        }
      end
      redirect_to @ac
    else
      flash[:warning] = 'Please make sure that the item you trying to upload has a picture as well '
      render 'new'
    end
  end

  def search
    @locations = ['Auckland Park', 'Braam', 'Soweto']
    @Inst = ['UJ ', 'Wits', 'Other']
    @acs = Accommodation.search(term: params[:search], location: params[:location], room_type: params[:room_type], price_from: params[:price_from], price_to: params[:price_to]).paginate(:per_page => 16, :page => params[:page])
  end

  def secure_room
    #todo check if the user is actually not a host
    host_id = params['user']['host_id']
    student_id = params['user']['std_id']
    booking_type = params['user']['booking_type']
    advert_id = params['id']
    #pron to Sql injection
    #booking type information 1 is secure and 0 is view
    #todo make sure that a person can not secure a room twice
    @k = nil
    if booking_type == "1"
      #todo check this man
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").where("booking_type = 't' ").count == 0
        t = Transaction.new(user_id: student_id, accomodation_id: advert_id, host_id: host_id, booking_type: 1, paid: 0)
        ad = Accommodation.find(advert_id)
        ad.is_secured = true
        ad.save! #todo put this in the models some how #before_action?
        @k = t.save!
      end
    elsif booking_type == "0" #booking type = 0 = view accomodation
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").where("booking_type = 'f' ").count == 0
        p = params['user']
        month = p['starts_at(1i)'] + make_two_digits(p['starts_at(2i)']) + make_two_digits(p['starts_at(4i)'])
        time = p['starts_at(4i)'] + " " + p['starts_at(5i)']

        t = Transaction.new(user_id: student_id, accomodation_id: advert_id, host_id: host_id, booking_type: 0, paid: 0, time: time, month: month)
        @k = t.save!
      end
    end
    respond_to do |format|
      # format.html
      format.js
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
    redirect :back
  end

  def student_pay
    @ac = nil
    ac_id = params[:id]
    student_id = params[:student_id]
    the_trans = Transaction.find(params[:trans_id])
    unless the_trans.nil?
      the_trans.std_confirm = true
      the_trans.save
    end
    respond_to do |format|
      format.js
    end
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
                           confirmed that we have recieved your request to secure the
                           room. You can go
                           ahead and deposit #{acc.price} using banking details
                           attached below \n #{host.bank_details} \n your reference number: #{student.token}"
      the_trans.save
    end
    redirect_to :back
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
    @ac = nil
    ac_id = params[:id]
    student_id = params[:student_id] #todo extract  these getting too much
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

  def show
    @ac = Accommodation.find(params[:id])
    views = @ac.views
    views += 1 if @ac.user != current_user
    @ac.update_attribute(:views, views) if @ac.user != current_user
  end

  def destroy
    @acs = Accommodation.find(params[:id])
    t = Transaction.find_by_accomodation_id(acs.id)
    t.destroy
    @acs.destroy
    redirect_to accommodations_path
  end


  private
  def acc_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:accommodation).permit!
  end

  def make_two_digits(digit)
    digit.length < 2 ? "0#{digit}" : digit
  end
end
