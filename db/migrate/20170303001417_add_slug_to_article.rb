class AddSlugToArticle < ActiveRecord::Migration[5.0]
  def change
    add_column :accommodations, :slug, :string
    add_index :accommodations, :slug, unique: true
  end
end
