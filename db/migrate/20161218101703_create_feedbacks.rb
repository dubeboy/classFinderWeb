class CreateFeedbacks < ActiveRecord::Migration[5.0]
  def change
    create_table :feedbacks do |t|
      t.string :question
      t.string :info

      t.timestamps
    end
  end
end
