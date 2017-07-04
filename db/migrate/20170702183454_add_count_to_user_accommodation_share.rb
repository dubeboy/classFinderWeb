class AddCountToUserAccommodationShare < ActiveRecord::Migration[5.0]
  def change
    add_column :user_accommodation_shares, :count, :integer, default: 0
  end
end
