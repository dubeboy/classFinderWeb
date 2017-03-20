class Api::V1::BooksController < ApplicationController

  # before_action :authenticate_user!, except: [:index, :show, :search]
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
       b = Book.search(params[:search]).paginate(page: params[:page], per_page: 16).order(created_at: :desc) if params[:search]
       @books = b.where(category_id:  params[:category].to_i)
      respond_to  do |format|
        format.json
      end
  end
  
  def create
    @status = false
    @book = Book.new(title: params[:book_title], 
                                           author: params[:author], 
                                           price: params[:price], 
                                           category_id: params[:category_id],
                                           description: params[:description])
    
    @book.user = User.find(params[:user_id])
    @book.institution = Institution.find(params[:institution_id])
    if params[:images]
      if @book.save
        params[:images].each { |image|
          @book.pictures.create(image: image)
        }
        @status = true
      end
    else
    end
    respond_to  do |format|
      format.json
    end
  end

  private
  def books_params
    #params.require(:item).permit(:price, :name, :description, {avatars: []})
    params.require(:book).permit!
  end

end
