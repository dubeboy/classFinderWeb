class Like < ActiveRecord::Base

  has_many :users
  has_many :items

  validates_uniqueness_of :user_id, scope: [:item_id, :user_id]

  def self.like(item, user)
    begin
      k = self.create!(user_id: user.id, item_id: item.id)
      if k
        true
      else
        false
      end
    rescue Exception
      false
    end
  end



end
