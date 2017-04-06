class Like < ActiveRecord::Base

  has_many :users
  has_many :items
  has_many :posts

  #validates_uniqueness_of :user_id, scope: [:item_id, :user_id]
  validates_uniqueness_of :post_id, scope: [:post_id, :user_id]

  def self.like(item, user)
      self.create(user_id: user.id, item_id: item.id)
  end

  def self.post_like(post, user)
  		b = self.new(user_id: user.id, post_id: post.id)
      return b.save
  end


end
