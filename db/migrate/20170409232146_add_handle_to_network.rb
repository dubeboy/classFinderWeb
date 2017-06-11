class AddHandleToNetwork < ActiveRecord::Migration[5.0]
  def change
    add_column :networks, :handle, :string
  end
end
