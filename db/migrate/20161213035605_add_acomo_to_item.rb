class AddAcomoToItem < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :city, :string
    add_column :items, :institution, :string
    add_column :items, :room_type, :string
  end
end
