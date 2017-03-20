class Api::V1::NetworksController < ApplicationController
  def index

  end


  def create
  	user = User.find(params[:user_id])
    net_cat = NetworkCategory.find(params[:net_cat])
    network = Network.new(name: params[:network_name])
    network.user = user
    network.network_category = net_cat
    @status = network.save!
    respond_to  do |format|
      format.json
    end
  end
end
