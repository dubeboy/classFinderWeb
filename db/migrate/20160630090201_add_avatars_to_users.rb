class AddAvatarsToUsers < ActiveRecord::Migration
  def change
    add_column :items, :avatars, :json
  end
end
