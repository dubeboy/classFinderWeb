class AccommodationsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show , :search]

  def index     #fixme
    @acs = Accommodation.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    @locations = ['Auckland Park', 'Braam', 'Soweto']
    @Inst = ['UJ ', 'Wits', 'Other']
  end

  def new
    @ac = Accommodation.new
  end

  #todo only varified users can create accomodations
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
    @acs = Accommodation.search(term:params[:search], location: params[:location], room_type: params[:room_type], price_from: params[:price_from], price_to: params[:price_to]).paginate(:per_page => 16, :page => params[:page])
  end

  def secure_room
    #todo check if the user is actually not a host
    host_id = params['user']['host_id']
    student_id = params['user']['std_id']
    booking_type = params['user']['booking_type']
    advert_id = params['id']
    #pron to Sql injection todo fixme sql injection
    #booking type information 1 is secure and 0 is view
    #todo make sure that a person can not secure a room twice
    k = nil
    if (booking_type == 1)
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").count == 0
        t = Transaction.new(user_id: student_id, accomodation_id: advert_id, host_id: host_id, booking_type: 1, paid: 0)
        k = t.save!
      end
    else
      if Transaction.where("user_id='#{student_id}' and accomodation_id='#{advert_id}'").count == 0
        t = Transaction.new(user_id: student_id, accomodation_id: advert_id, host_id: host_id, booking_type: 0, paid: 0)
        k = t.save!
      end
    end
    respond_to do |format|
      msg = { :status => "ok", :k => k, :html => "<b>Updated Or Not</b>" }
      format.json  { render :json => msg } # don't do msg.to_json
    end
  end


  def pay
    @ac = Accommodation.find(params[:id])
    # this_users_trasactions = Transaction.
  end

  def show
    @ac = Accommodation.find(params[:id])
    views = @ac.views
    views += 1 if @ac.user != current_user
    @ac.update_attribute(:views, views) if @ac.user != current_user
  end


  def destroy
    @acs = Accommodation.find(params[:id])
    @acs.destroy
    redirect_to accommodations_path
  end


  private
  def acc_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:accommodation).permit!
  end
end
