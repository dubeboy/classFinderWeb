class CreateBooksTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :books_transactions do |t|
      t.integer :user_id
      t.integer :buyer_id
      t.boolean :sold, default: false
      t.boolean :in_trans, default: false
      t.string :time

      t.timestamps
    end
  end
end
