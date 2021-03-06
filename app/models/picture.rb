class Picture < ActiveRecord::Base
  belongs_to :Item

  has_attached_file :image,
                    :styles => { :medium => "300x300", thumb: "200x200#" }, default_url: "logo.png"

  validates_attachment_content_type :image, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']
  validates_attachment_presence :image
end
