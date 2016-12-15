class Book < ApplicationRecord

  #todo check validity in  the model it self
  has_many :pictures, :dependent => :destroy
  belongs_to :category
  belongs_to :user
  has_one :institution  #we dont need to validate intitution

  #validaton
  validates_presence_of :title, :price, :description, :author
  validates_presence_of :category , :user
end
