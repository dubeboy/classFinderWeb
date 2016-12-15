class AddTotLikesToAccommodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :tot_likes, :integer
  end
end
