class CreateHouses < ActiveRecord::Migration[5.0]
  def change
    create_table :houses do |t|
      t.string :address
      t.string :wifi
      t.integer :user_id
      t.boolean :nsfas
      t.string :common
      t.boolean :prepaid_elec
      t.integer :accommodation_id

      t.timestamps
    end
  end
end
