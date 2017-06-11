class CreateSubcriptions < ActiveRecord::Migration[5.0]
  def change
    create_table :subscriptions do |t|
      t.integer :user_id
      t.string :network_id
      t.index [:user_id, :network_id]
      t.timestamps
    end
  end
end
