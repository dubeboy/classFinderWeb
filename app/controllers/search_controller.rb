class SearchController < ApplicationController
  def index
    @cat = Category.all
    if params[:category] == "1"
        @acs = Accommodation.search( term: params[:search]).paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    else
      unless @books.nil?
        @books = Book.search(params[:search]).paginate(page: params[:page], per_page: 16).order(created_at: :desc)
      end
    end
  end
end
