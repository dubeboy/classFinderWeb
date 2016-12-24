class AddRunnerIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :runner_id, :integer
  end
end
