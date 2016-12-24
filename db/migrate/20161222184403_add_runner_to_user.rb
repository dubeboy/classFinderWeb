class AddRunnerToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :runner, :boolean
  end
end
