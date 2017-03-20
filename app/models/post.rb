class Post < ApplicationRecord
  has_many :pictures, :dependent => :destroy
  belongs_to :network
end
