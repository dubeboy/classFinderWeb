class SearchController < ApplicationController
  def index
    @cat = Category.all
    if params[:category]
      @items = Category.search(params[:category]).items.search(params[:search]).paginate(:per_page => 16, :page => params[:page])
    else
      items = Item.search(params[:search]) #16 coz 3 per row
      @items = items ? items.paginate(:per_page => 16, :page => params[:page]).order('created_at DESC') : nil
    end
  end
end
