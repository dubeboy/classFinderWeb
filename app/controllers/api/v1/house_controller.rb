class Api::V1::HouseController < ApplicationController
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
    @house = House.new(house_params)
    @status = false

    params[:accommodations].each do |accom|
      @house.accommodations.create(accom)
    end if params[:accommodations] #flying fish code haahahahahahahah
    if @house.save
      @status = true
    end
  end
  def search

  end
  private
  def house_params
    params.require(:house).permit!
  end
end
