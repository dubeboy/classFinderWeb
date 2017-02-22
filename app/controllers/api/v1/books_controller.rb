class Api::V1::BooksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    if params['cat']
      @books =  Category.find(params['cat']).books.all.paginate(page: params[:page],
                                                                   per_page: 16).order(created_at: :desc)
    else
      @books = Book.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    end
    respond_to do |format| 
      format.json
    end 
  end

  #books/1 todo moght change from 16 to somthing else time and stress to our system
  def show
    @book = Book.find(params[:id])
  end


  def search
      @books = Book.search(params[:search]).paginate(page: params[:page], per_page: 6).order(created_at: :desc) if params[:search]
      respond_to  do |format|
        format.json
      end
  end


  
  def create
    @book = Book.new(title: params[:title], 
                                           author: params[:author], 
                                           price: params[:price], 
                                           category_id: params[:category_id],
                                           description: params[:description])
    
    @book.user = User.find(params[:user_id])
    @book.institution = Institution.find(params[:category_id])
    if params[:images]
      if @book.save
        params[:images].each { |image|
          @book.pictures.create(image: image)
        }
      end
      # redirect_to @book
    else
      flash[:warning] = 'Please make sure that the book you trying to upload has a picture as well '
    end
  end

  private
  def books_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:book).permit!
  end

end
