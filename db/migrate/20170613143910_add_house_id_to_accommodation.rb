class AddHouseIdToAccommodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :house_id, :integer
  end
end
