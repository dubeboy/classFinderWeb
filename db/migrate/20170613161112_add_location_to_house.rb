class AddLocationToHouse < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :location, :string
    add_column :houses, :city, :string
    add_column :houses, :string, :string
  end
end
