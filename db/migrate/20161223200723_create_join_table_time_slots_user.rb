class CreateJoinTableTimeSlotsUser < ActiveRecord::Migration[5.0]
  def change
    create_join_table :users, :time_slots do |t|
      t.index [:user_id, :time_slot_id]
      t.index [:time_slot_id, :user_id]
    end
  end
end
