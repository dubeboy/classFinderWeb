class AddTIdAccomodation < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :transaction_id, :integer
  end
end
