class AddDayToBooksTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :books_transactions, :day, :string
  end
end
