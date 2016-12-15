class AddHostIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :host_id, :integer
  end
end
