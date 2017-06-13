class House < ApplicationRecord
  has_many :accommodations
  belongs_to :user
  validates_presence_of :accommodations
end
