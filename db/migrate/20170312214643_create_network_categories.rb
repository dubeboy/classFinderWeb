class CreateNetworkCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :network_categories do |t|
      t.string :name, unique: true

      t.timestamps
    end
    add_index :network_categories, :name, unique: true
  end
end
