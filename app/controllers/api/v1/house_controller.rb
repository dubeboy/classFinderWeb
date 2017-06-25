class Api::V1::HouseController < ApplicationController
  swagger_controller :users, "House Man"


  def index
    @houses = House.all.paginate(page: params[:page],
                                      per_page: 20).order(created_at: :desc)
    respond_to do |format|
      format.json
      format.html
      format.js
    end
  end

  def update
    @house = House.find(params[:id])
    @house.update(house_params)
  end

  def show
    @house = House.find(params[:id])
  end

  def get_accoms
    house = House.find(params[:id])
    @accoms = house.accommodations

    respond_to do |format|
      format.json
      format.html
      format.js
    end

  end


  def create
    @status = false
    @my_house = nil
    address = params[:address]
    @house = House.new(
        address: address,
        location: params[:location],
        city: params[:city],
        wifi: params[:wifi],
        nsfas: params[:nsfas],
        common: params[:common],
        prepaid_elec: params[:prepaid_elec],
        country: 'South Africa'
    )

    @house.user = User.find(params[:user_id])

    v = @house.save!
    if v
      @status = true
      @my_house = House.where('address = ?', address).limit(1)[0]
    end
    puts address + ": thats the address man"
    respond_to do |format|
      format.json
      format.html
      format.js
    end
  end

  def search
  end

  private
  def house_params
    params.require(:house).permit!
  end
end