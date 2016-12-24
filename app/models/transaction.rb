class Transaction < ApplicationRecord

  has_many :users
  has_many :accommodations

  def self.find_unique_row(host_id, accommodation_id)
    where("host_id = ? and accomodation_id = ?", host_id, accommodation_id).first
  end

end
