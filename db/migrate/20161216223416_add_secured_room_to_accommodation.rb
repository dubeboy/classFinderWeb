class AddSecuredRoomToAccommodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :is_secured, :boolean
  end
end
