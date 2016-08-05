class Item < ActiveRecord::Base

  belongs_to :user
  has_many :pictures, :dependent => :destroy
  validates_associated :pictures
  belongs_to :category
  validates_presence_of :price, :name, :description
  has_many :likes



  def self.search(term)
    if term
      where("name LIKE ?", "%#{term}%")
    else
      nil
    end
  end
end
