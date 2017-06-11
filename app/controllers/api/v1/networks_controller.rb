
class Api::V1::NetworksController < ApplicationController
  def index
    n = Network.all.paginate(page: params[:page], per_page: 30).order(created_at: :desc)
    @networks = n.where('network_category_id=? AND network_type=?',
                                                  params[:network_id], params[:network_type])
    @current_user = User.find(params[:user_id])
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

  def subscribe
    subs = Subscription.new(user_id: params[:user_id], network_id: params[:network_id] )
     if (subs.save) #if the user is subscribing for the first time
        @status = true
     else
       s = Subscription.where("user_id = ? and network_id = ?", params[:user_id], params[:network_id])
       s.destroy
       @status = false
     end
  end

  def search
      term = params[:term]
      if term[0] == "@"
          #just grep one with that particular name ignore case!
        @network  =  Network.where("name like ?", "#{term}").first
      else
          #just grep everything!
        @networks = Network.where("name like ? or desc like ?", "%#{term}%", "%#{term}%").first
      end
  end

end
