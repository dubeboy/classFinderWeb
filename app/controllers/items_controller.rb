class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
    @category = Category.all
  end

  def create
    @item = Item.new(item_params)
    @item.user = current_user
    @item.category = Category.find(params[:item][:category_id])
    #Category.item = @Item
    if @item.save
      if params[:images]
       params[:images].each { |image|
         @item.pictures.create(image: image)
       }
      end
      redirect_to @item
    else
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def item_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:item).permit!
  end
end
