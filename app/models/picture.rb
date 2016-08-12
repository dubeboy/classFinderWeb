class Picture < ActiveRecord::Base
  belongs_to :Item

  has_attached_file :image,
                    :storage => :google_drive,
                    :google_drive_credentials => "#{Rails.root}/config/google_drive.yml",
                    :styles => { :medium => "300x300", thumb: "200x200" },
                    :google_drive_options => {
                    :path => proc { |style| "#{style}_#{id}_#{photo.original_filename}" }
  }

  validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_presence :image
end
