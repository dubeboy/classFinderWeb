class Book < ApplicationRecord

  #todo check validity in  the model it self
  has_many :pictures, :dependent => :destroy
  belongs_to :category
  belongs_to :user
  has_one :institution  #we dont need to validate intitution

  #validaton
  validates_presence_of :title, :price, :description, :author
  validates_presence_of :category , :user


  def self.search(term, institution='', room_type='')
    if term
      return where('title like ? or description like ?', "%#{term}%", "%#{term}%")
    else
      return nil
    end
  end
end
