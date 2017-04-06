class Api::V1::NetworksController < ApplicationController
  def index
    n = Network.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    @networks = n.where('network_category_id=? AND network_type=?',
                                                  params[:network_id], params[:network_type])
    respond_to  do |format|
      format.json
    end
  end

  # this is network topic dude
  # this belong to Network and has posts
  def create
  	user = User.find(params[:user_id])
    net_cat = NetworkCategory.find(params[:net_cat])
    network = Network.new(name: params[:network_name], desc: params[:desc],
                                                                network_type: params[:network_type])
    network.user = user
    network.network_category = net_cat
    @status = network.save!
    respond_to  do |format|
      format.json
    end
  end
end
