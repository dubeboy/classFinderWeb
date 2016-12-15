class Transaction < ApplicationRecord

  has_many :users
  has_many :accommodations

end
