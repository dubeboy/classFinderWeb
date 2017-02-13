class CreateBooksTimeSlot < ActiveRecord::Migration[5.0]
  def change
    create_table :books_time_slots do |t|
      t.string :time
    end
  end
end
