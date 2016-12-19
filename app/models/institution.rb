class Institution < ApplicationRecord
  validates_presence_of :name, :location
  validates_uniqueness_of :name
end
