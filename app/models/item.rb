class Item < ActiveRecord::Base

  belongs_to :user
  has_many :pictures, :dependent => :destroy
  validates_associated :pictures
  belongs_to :category
  validates_presence_of :price, :name, :description
  validates :category_id, presence: true

  has_many :likes

  #todo bad code
  def self.search(term, institution='', room_type='')
    if term
     k = where('name like ? or description like ?', "%#{term}%", "%#{term}%")
      if !institution.empty?
         k = where('name like ? or description like ? or institution like ? ', "%#{term}%", "%#{term}%","%#{institution}%" )
        if !room_type.empty?
          k = where('name like ? or description like ? or institution like ? or room_type like ?', "%#{term}%", "%#{term}%","%#{institution}%", "%#{room_type}" )
        end
      end
      #todo do u need an institution to view room type?
      if !room_type.empty? and institution.empty?
        k = where('name like ? or description like ? or room_type like ? ', "%#{term}%", "%#{term}%","%#{room_type}" )
      end

      return k
    else
      return nil
    end
  end

end
