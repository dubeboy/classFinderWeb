class TimeSlot < ApplicationRecord
  validates_presence_of :time
  validates_uniqueness_of :time
  has_and_belongs_to_many :users
end
