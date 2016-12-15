class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :user_id
      t.integer :accomodation_id
      t.boolean :paid
      t.boolean :booking_type
      t.boolean :std_confirm

      t.timestamps
    end
  end
end
