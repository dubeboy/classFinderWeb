class AddPictureIdToBook < ActiveRecord::Migration[5.0]
  def change
    add_column :books, :picture_id, :integer
  end
end
