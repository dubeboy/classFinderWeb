class AddNearToIdToHouse < ActiveRecord::Migration[5.0]
  def change
    add_column :houses, :nearto_id, :string
  end
end
