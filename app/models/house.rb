class House < ApplicationRecord
  has_many :accommodations
  belongs_to :user
  has_many :near_tos
  has_many :pictures, :dependent => :destroy
  validates_presence_of :user, :address
  validates_uniqueness_of :address
end
