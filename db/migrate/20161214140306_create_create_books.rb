class CreateCreateBooks < ActiveRecord::Migration[5.0]
  def change
    create_table :books do |t|
      t.string :title
      t.integer :category_id
      t.decimal :price
      t.text :description
      t.string :author
      t.integer :user_id
      t.integer :institution_id

      t.timestamps
    end
  end
end
