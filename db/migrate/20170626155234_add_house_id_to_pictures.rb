class AddHouseIdToPictures < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :house_id, :integer
  end
end
