class AccomodationController < ApplicationController
  def index
   @items = Category.first.items.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(a-cc_params)
    @item.user = current_user
    @item.category = Category.find(1)
    if params[:images]
      if @item.save
        params[:images].each { |image|
          @item.pictures.create(image: image)
        }
      end
      redirect_to @item
    else
      flash[:warning] = 'Please make sure that the item you trying to upload has a picture as well '
      render 'new'
    end
  end

  def show
    @item = Item.find(params[:id])
    views = @item.views
    views += 1 if @item.user != current_user
    @item.update_attribute(:views, views) if @item.user != current_user
  end

  private
  def acc_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:accomodation).permit!
  end
end
