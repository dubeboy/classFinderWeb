class AddBookIdToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :book_id, :integer
  end
end
