class CreateCreateAccomodations < ActiveRecord::Migration[5.0]
  def change
    create_table :accommodations do |t|
      t.string :location
      t.string :room_type
      t.decimal :price
      t.text :description
      t.integer :user_id
      t.integer :view

      t.timestamps
    end
  end
end
