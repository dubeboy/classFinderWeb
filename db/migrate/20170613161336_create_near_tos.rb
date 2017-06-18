class CreateNearTos < ActiveRecord::Migration[5.0]
  def change
    create_table :near_tos do |t|
      t.string :name
      t.string :location

      t.timestamps
    end
  end
end
