class AddBooksIdToInstitutions < ActiveRecord::Migration[5.0]
  def change
    add_column :institutions, :book_id, :integer
  end
end
