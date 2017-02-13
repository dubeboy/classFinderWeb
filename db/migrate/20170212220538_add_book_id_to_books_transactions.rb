class AddBookIdToBooksTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :books_transactions, :book_id, :integer
  end
end
