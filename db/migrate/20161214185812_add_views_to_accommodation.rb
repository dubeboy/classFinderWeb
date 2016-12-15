class AddViewsToAccommodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :views, :integer, default: 0
  end
end
