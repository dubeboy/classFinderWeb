class AddTimeMonthToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :month, :string
    add_column :transactions, :time, :string
  end
end
