class Post < ApplicationRecord
  has_many :pictures, :dependent => :destroy
  belongs_to :network
  belongs_to :user
  has_many :comments
end
