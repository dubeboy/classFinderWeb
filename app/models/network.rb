class Network < ApplicationRecord
  belongs_to :network_category
  belongs_to :user
  has_many :posts
  has_many :subscriptions

  validates_presence_of :name
  validates_presence_of :desc
  validates_uniqueness_of :name
end
