class BooksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @books = Book.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc) #find book by ID
  end

  #books/1 todo moght change from 16 to somthing else time and stress to our system
  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(books_params)
    @book.user = current_user
    i = Institution.new(name: params[:inst_name])
    @book.institution = params[:category_id]
    if params[:images]
      if @book.save
        params[:images].each { |image|
          @book.pictures.create(image: image)
        }
      end
      redirect_to @book
    else
      flash[:warning] = 'Please make sure that the book you trying to upload has a picture as well '
      render 'new'
    end
  end

  private
  def books_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:book).permit!
  end

end
