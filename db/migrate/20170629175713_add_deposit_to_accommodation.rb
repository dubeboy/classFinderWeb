class AddDepositToAccommodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :deposit, :decimal, :precision => 8, :scale => 2
  end
end
