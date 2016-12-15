class SearchController < ApplicationController
  def index
    @cat = Category.all
    if params[:category]
      kat = Category.search(params[:category])
      @items = kat.items.search(params[:search]).paginate(:per_page => 16, :page => params[:page])
      if params[:name]  # if this is there them we need a better search name = location
        @items = kat.items.search(params[:search], institution: params[:institution], room_type: params[:room_type]).paginate(:per_page => 16, :page => params[:page])
        redirect_back
      end
    else
      items = Item.search(params[:search]) #16 coz 3 per row
      @items = items ? items.paginate(:per_page => 16, :page => params[:page]).order('created_at DESC') : nil
    end
  end
end
