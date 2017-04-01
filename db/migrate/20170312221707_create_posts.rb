class CreatePosts < ActiveRecord::Migration[5.0]
  def change
    create_table :posts do |t|
      t.string :name, unique: true
      t.text :description
      t.integer :views
      t.integer :likes, default: 0

      t.timestamps
    end
    add_index :posts, :name, unique: true
  end
end
