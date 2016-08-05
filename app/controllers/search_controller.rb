class SearchController < ApplicationController
  def index

    @cat = Category.all
    if params[:category]
      @items = Category.search(params[:category]).items.search(params[:search]).paginate(:per_page => 12, :page => params[:page])
    else
      items = Item.search(params[:search]) #12 coz 3 per row
      @items = items ? items.paginate(:per_page => 12, :page => params[:page]) : nil
    end
  end
end
