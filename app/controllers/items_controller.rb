class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :likes]
  rescue_from ActiveRecord::RecordInvalid, with: :show_errors

  def index
    @items = Item.all
    @cat = Category.all
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
    views = @item.views + 1
    @item.update_attribute(:views, views) if @item.user != current_user #coz the user who created the item knows it duh... same here
  end

  def like #todo not working properly
     item = Item.find(params[:id])
     like = Like.like(item, current_user) #should return these should be called thru Item model(let this = same here)

     if like
       lk = item.tot_likes = item.likes.count
       item.update_attributes(tot_likes: lk ) #same here
       render status: :created,
              json: {
                  success: true,
                  likes: item.tot_likes,
                  notice: 'You just liked an Item'
              }
     else

       render status: :unprocessable_entity,
              json: {
                  success: false,
                    notice: 'Check if you logged in'
              }
     end
  end


  def likes
    item = Item.find(params[:id])
    render status: :ok,
           json: {
               success: true,
               likes: item.tot_likes
           }
  end

  private
  def item_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:item).permit!
  end

  def show_errors
    render status: :unprocessable_entity,
           json: {
               success: false,
               notice: 'You cannot like the same item twice and Check if you logged in'
           }
  end
end
