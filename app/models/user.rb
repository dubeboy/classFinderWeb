class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password

  has_many :items

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :name, :contacts
  validates_uniqueness_of :email
  validates_length_of :password, :minimum => 4, :too_short => "please enter at least %d characters"
  validates_length_of :contacts, :in => 3..12, :allow_blank => true # todo make range better boy

  has_attached_file :cover, styles: { medium: "1141x290>", thumb: "100x100>" }, default_url: "/images/default_cover.png"
  has_attached_file :profile_img, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/profile.png"

  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :profile_img, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  def self.authenticate(email, password)
    user = find_by_email(email)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
end
