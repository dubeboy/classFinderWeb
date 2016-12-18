class AddMessageToTransaction < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :message, :text
  end
end
