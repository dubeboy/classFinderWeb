class NearTo < ApplicationRecord
  belongs_to :house
  validates_uniqueness_of :location
  validates_presence_of :location
end
