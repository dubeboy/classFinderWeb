class AddDescriptionToItems < ActiveRecord::Migration
  def change
    add_column :items, :description, :text
    add_column :users, :item_id, :integer
  end
end
