class CreateNetworks < ActiveRecord::Migration[5.0]
  def change
    create_table :networks do |t|
      t.string :name, unique: true

      t.timestamps
    end
    add_index :networks, :name, unique: true
  end
end
