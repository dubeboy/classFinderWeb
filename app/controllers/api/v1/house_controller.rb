class Api::V1::HouseController < ApplicationController
  swagger_controller :users, "House Man"


  def index
    user_id = params[:user_id]
    user = User.find(user_id)
    @houses = user.houses.all.paginate(page: params[:page],
                                      per_page: 20).order(created_at: :desc)
    respond_to do |format|
      format.json
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
    addre = address.split(',')
    city = addre[2].strip
    location = addre[1].strip
    country = addre[4].strip
    @house = House.new(
        address: address,
        wifi: params[:wifi],
        city: city,
        location: location,
        nsfas: params[:nsfas],
        common: params[:common],
        prepaid_elec: params[:prepaid_elec],
        country: country,
        laundry: params[:laundry]
    )

    @house.user = User.find(params[:user_id])
    
    if params[:images]
      puts 'there are images########################################'
      if @house.save!
        params[:images].each { |image|
          puts '######################################'
          puts image
          puts '######################################'
          @house.pictures.create(image: image)
        }
        @status = true
        near_tos_array = Array.new
         params[:near_to].strip.split(',').each { |near|
         near = near.strip
         n = NearTo.new(location: near)
         unless (n.save)  #this happens when the  location already exists
           n = NearTo.find_by_location(near)
         end 
         near_tos_array.push(n)
          # @house.near_tos.create(n)
         }
        @house.near_tos = near_tos_array
        @my_house = House.where('address = ?', address).limit(1)[0]
      end
      # redirect_to @ac  todo: should look into this man
    else
      @status = false
    end
    puts address + ": thats the address man"
    respond_to do |format|
      format.json
    end
  end

  def search
  end

  private
  def house_params
    params.require(:house).permit!
  end
end
