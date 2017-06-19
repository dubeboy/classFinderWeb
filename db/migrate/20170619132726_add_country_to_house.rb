class AddCountryToHouse < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :country, :string
  end
end
