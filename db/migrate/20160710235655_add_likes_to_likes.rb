class AddLikesToLikes < ActiveRecord::Migration
  def change
    add_column :items, :tot_likes, :integer, default: 0
  end
end
