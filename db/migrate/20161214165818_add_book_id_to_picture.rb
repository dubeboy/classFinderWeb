class AddBookIdToPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :book_id, :integer
  end
end
