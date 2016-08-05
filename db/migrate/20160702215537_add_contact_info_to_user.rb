class AddContactInfoToUser < ActiveRecord::Migration
  def change
    add_column :users, :contacts, :string
  end
end
