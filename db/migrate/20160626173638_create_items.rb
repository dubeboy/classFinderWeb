class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.decimal :price
      t.string :name
      t.belongs_to(:user, foreign_key: true)

      t.timestamps null: false
    end
  end
end
