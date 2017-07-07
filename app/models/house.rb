class House < ApplicationRecord
  has_many :accommodations
  belongs_to :user
  has_many :near_tos
  has_many :pictures, :dependent => :destroy
  validates_presence_of :user, :address
  validates_uniqueness_of :address

  # def self.search(nsfas, location)
  #   h = where('nsfas = ? and location = ?', nsfas, location)
  #   h.each do |h|
  #     h.accommodations.each do |a|
  #       @acs.append(a.search(params[:room_type],
  #                            price_from: params[:price_from],
  #                            price_to: x))
  #     end
  #   end
  #
  # end
end
