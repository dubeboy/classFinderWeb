class House < ApplicationRecord
  has_many :accommodations
  belongs_to :user
  has_many :near_tos
  validates_presence_of :user, :address, :nsfas
  validates_uniqueness_of :address
end
