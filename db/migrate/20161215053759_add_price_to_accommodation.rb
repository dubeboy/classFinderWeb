class AddPriceToAccommodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :price_to, :integer
    add_column :accommodations, :price_from, :integer
  end
end
