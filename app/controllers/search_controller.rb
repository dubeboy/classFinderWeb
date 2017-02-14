class SearchController < ApplicationController
  def index
    @cat = Category.all.select { |x| x if x.book_type == "Book"}
    if params[:category] == "1"
        @acs = Accommodation.msearch(params[:search]).paginate(page: params[:page], per_page: 16).order(created_at: :desc)
    else
      @books = Book.search(params[:search]).paginate(page: params[:page], per_page: 16).order(created_at: :desc) if params[:search]
      respond_to  do |format|
        format.html
        format.json
        format.js
      end
    end
  end
end
