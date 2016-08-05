class Profile < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :instergram, :twitter, :facebook

  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/default_cover.png"
  has_attached_file :profile_img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/profile.png"
  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :profile_img, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  #validate content type
end