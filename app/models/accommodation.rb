class Accommodation < ApplicationRecord
  belongs_to :user
  has_many :pictures, :dependent => :destroy
  validates_presence_of :location, :room_type, :description, :price


#no sql injection here
  def self.search(location, room_type, price_from: 0, price_to: 0, precise_loc: '')
    if !precise_loc.empty?
      k = where('location = ? and room_type = ? and institution = ?', location, room_type, precise_loc)
    else
      k = where('location = ? and room_type = ?', location, room_type)
    end
    if price_from.to_i >= 0 and price_to.to_i > 0
      k = k.where('price >= ? and price <= ?', price_from, price_to)
    end
    return k
  end

# @overload fro overall search does not work in ruby
  def self.msearch(term)
    k = where('description like ?', "%#{term}")
    return k
  end
end

