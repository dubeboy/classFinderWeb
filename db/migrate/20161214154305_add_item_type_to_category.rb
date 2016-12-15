class AddItemTypeToCategory < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :book_type, :string
  end
end
