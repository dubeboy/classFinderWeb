class AddHouseIdToNearTo < ActiveRecord::Migration[5.0]
  def change
    add_column :near_tos, :house_id, :integer
  end
end
