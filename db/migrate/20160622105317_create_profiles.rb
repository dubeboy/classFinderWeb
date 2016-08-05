class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :handle
      t.string :name
      t.string :facebook
      t.string :twitter
      t.string :instergram

      t.timestamps null: false
    end
  end
end
