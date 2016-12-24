class AddRunLocationToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :run_location, :string
  end
end
