class Network < ApplicationRecord
  belongs_to :network_category
  belongs_to :user
  has_many :posts

  validates_presence_of :name
  validates_presence_of :desc
end
