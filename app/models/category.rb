class Category < ActiveRecord::Base
  has_many :items
  has_many :books
  validates_uniqueness_of :name

  def self.search(id)
    if id
      self.find(id)
    else
      nil
    end
  end
end
