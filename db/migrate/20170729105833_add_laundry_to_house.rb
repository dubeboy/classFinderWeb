class AddLaundryToHouse < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :laundry, :boolean
  end
end
