class House < ApplicationRecord
  has_many :accommodations
  validates_presence_of :accommodations
end
