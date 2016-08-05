class Category < ActiveRecord::Base
  has_many :items

  def self.search(id)
    if id
      self.find(id)
    else
      nil
    end
  end
end
