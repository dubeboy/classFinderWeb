class AddAccommodationIdToPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :accommodation_id, :integer
  end
end
