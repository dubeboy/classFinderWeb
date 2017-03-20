class AddUserIdToNetwork < ActiveRecord::Migration[5.0]
  def change
    add_column :networks, :user_id, :integer
  end
end
