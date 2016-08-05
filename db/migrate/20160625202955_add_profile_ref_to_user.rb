class AddProfileRefToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references(:profile)
    end
  end
end
