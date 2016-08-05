class AddAssociationsToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :references, :user
  end
end
