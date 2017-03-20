class AddNetworkCategoryIdToNetwork < ActiveRecord::Migration[5.0]
  def change
    add_column :networks, :network_category_id, :integer
  end
end
