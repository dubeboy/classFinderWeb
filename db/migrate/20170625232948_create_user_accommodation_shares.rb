class CreateUserAccommodationShares < ActiveRecord::Migration[5.0]
  def change
    create_table :user_accommodation_shares do |t|
      t.string :user_token
      t.integer :accom_id

      t.timestamps
    end
  end
end
