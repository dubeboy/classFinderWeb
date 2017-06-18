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

  def create
    @status = false
    @house = House.new(
        address: params[:address],
        location: params[:location],
        city: params[:city],
        wifi: params[:wifi],
        nsfas: params[:nsfas],
        common: params[:common],
        prepaid_elec: params[:prepaid_elec],
        country: params[:country]
    )

    @house.user = User.find(params[:user_id])

    if @house.save
      @status = true
    end
    byebug #end the bugs : yeyyy TODO: show stopper #bye bug
  end
  def search

  end
  private
  def house_params
    params.require(:house).permit!
  end
end
