class AddTimeSlotsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :time_slots, :string
  end
end
