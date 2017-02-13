module BooksHelper

  def gen_style(book)
    bt = get_trans(book)
    if bt.in_trans?
      'in_trans'
    end
  end

  def get_trans(book)
    bt = BooksTransaction.where(book_id: book.id).first
  end
end
