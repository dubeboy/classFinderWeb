class AddSuperUserToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :king, :boolean
  end
end
