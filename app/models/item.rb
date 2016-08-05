class Item < ActiveRecord::Base

  belongs_to :user
  has_many :pictures, :dependent => :destroy
  belongs_to :category
  validates_presence_of :price, :name, :description
end
