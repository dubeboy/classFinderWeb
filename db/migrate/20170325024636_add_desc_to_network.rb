class AddDescToNetwork < ActiveRecord::Migration[5.0]
  def change
    add_column :networks, :desc, :network
  end
end
