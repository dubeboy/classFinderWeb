class Institution < ApplicationRecord
  validates_presence_of :name, :location
end
