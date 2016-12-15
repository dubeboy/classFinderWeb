class Accommodation < ApplicationRecord
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  validates_presence_of :location, :room_type, :description, :price



  def self.search(term: '',location: ' ', room_type: '', institution: '', price_from: 0 , price_to: 0)
        k = where('location like ? or description like ? or room_type like ? or institution like ? ', "%#{location}%", "%#{term}%", "%#{room_type}%", "%#{institution}%")
      if price_from.to_i > 0 and price_to.to_i > 0
          k = k.where("price >= ? and price <= ?", price_from, price_to)
      end
      return k
  end
end

