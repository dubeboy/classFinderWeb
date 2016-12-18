class AddGoAheadToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :go_ahead, :boolean
  end
end
