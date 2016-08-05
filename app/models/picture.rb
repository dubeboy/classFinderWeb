class Picture < ActiveRecord::Base
  belongs_to :Item

  has_attached_file :image,
                    styles: { medium: "231x176>", thumb: "100x100>" }, default_url: "/images/default_cover.png"

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_presence_of :image
end
