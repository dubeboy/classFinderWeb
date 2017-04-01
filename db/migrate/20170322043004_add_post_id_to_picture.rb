class AddPostIdToPicture < ActiveRecord::Migration[5.0]
  def change
    add_column :pictures, :post_id, :integer
  end
end
