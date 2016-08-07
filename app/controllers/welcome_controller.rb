class WelcomeController < ApplicationController
  def index
    @items_likes = Item.all.paginate(page: params[:page], per_page: 6).order(tot_likes: :desc)
    @items_views = Item.all.paginate(page: params[:page], per_page: 6).order(views: :desc)

    respond_to do |format|
      format.html
      format.js
    end
  end
end
