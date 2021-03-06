class CategoryController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Successfully created category "
      redirect_to root_path
    else
      flash[:danger] = "Could not create category"
      render 'new'
    end
  end
private

def category_params
  params.requre(:category).permit(:name)
end

end
