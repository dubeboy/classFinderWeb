class Item < ActiveRecord::Base

  belongs_to :user
  has_many :pictures, :dependent => :destroy
  validates_associated :pictures
  belongs_to :category
  validates_presence_of :price, :name, :description
  validates :category_id, presence: true

  has_many :likes


  def self.search(term) #todo make this search better
    if term
      where("name LIKE ?", "%#{term}%")
    else
      nil
    end
  end
end
