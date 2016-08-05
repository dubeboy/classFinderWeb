class AddReferenceToItem < ActiveRecord::Migration
  def change
    add_column :items, :picture_id, :integer
    add_column :pictures, :item_id, :integer
  end
end
