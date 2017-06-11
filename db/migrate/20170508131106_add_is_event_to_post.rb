class AddIsEventToPost < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :is_event, :boolean, default: false 
  end
end
