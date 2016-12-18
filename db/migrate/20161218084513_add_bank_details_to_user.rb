class AddBankDetailsToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :bank_details, :text
  end
end
