class BooksController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]

  def index
    @cat = Category.all.select { |x| x if x.book_type == 'Book' }
    if params['cat']
      @books =  Category.find(params['cat']).books.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    else
      @books = Book.all.paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    end
  end

  #books/1 todo moght change from 16 to somthing else time and stress to our system
  def show
    @book = Book.find(params[:id])
  end

  def new
    @book = Book.new
  end

  #handle all the new item being bought
  def buy
    prms = params[:user]
    bt = BooksTransaction.new(user_id: prms[:seller_id], buyer_id: prms[:buyer_id],
                              book_id: prms[:book_id], time: prms[:time], in_trans: true, day: prms[:day])

   @save =  bt.save!
    # if(@save)
    #   AgentTexter.alert(bt).deliver_now
    # end
  end

  def sold
    bt = BooksTransaction.find(params[:trans_id])
    bt.in_trans = false
    bt.sold = true
    bt.save
  end

  def create
    @book = Book.new(books_params)
    @book.user = current_user
    @book.institution = Institution.find(params[:book][:category_id])
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
