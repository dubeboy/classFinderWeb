class Accommodation < ApplicationRecord
  belongs_to :user
  belongs_to :house
  has_many :pictures, :dependent => :destroy
  validates_presence_of :room_type, :description, :price
  validates_presence_of :deposit


#no sql injection here
def self.search(room_type, price_from, price_to)

    puts '--------------------------the desert-------------------------------'
    puts room_type
    puts price_from
    puts price_to
    puts 'hello there --------------------------------------------------------'
    price_from = set_to_zero_if_empty(price_from)
    price_to = set_to_zero_if_empty(price_to)
    k = where('room_type = ?', room_type)
    if price_from.to_i >= 0 and price_to.to_i >= 0 #maybe there is a product that has 0 a 0 price
      k = k.where('price >= ? and price <= ?', price_from.to_i, price_to.to_i)
    end
    return k
  end


  #
  def search_it(room_type, price_from: 0, price_to: 0)
    self.class.search(room_type, price_from, price_to)
  end

  def self.set_to_zero_if_empty(price)
    return -1  if price.nil?
    if price.empty?
      return -1
    else
      return price
    end
  end

# @overload fro overall search does not work in ruby
  def self.msearch(term)
    k = where('description like ?', "%#{term}")
    return k
  end
end

