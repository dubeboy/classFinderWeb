class Network < ApplicationRecord
  belongs_to :network_category
  belongs_to :user

  validates_presence_of :name
end
