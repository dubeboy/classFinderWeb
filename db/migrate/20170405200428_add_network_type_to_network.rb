class AddNetworkTypeToNetwork < ActiveRecord::Migration[5.0]
  def change
    add_column :networks, :network_type, :integer
  end
end
