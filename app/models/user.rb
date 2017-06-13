class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password
  before_create :generate_token


  has_many :items
  has_many :accommodations
  has_many :books
  has_many :houses
  has_many :networks
  has_and_belongs_to_many :time_slots, dependent: :destroy
  has_many :subcriptions
  has_many :attend_events

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates_length_of :password, :on => :create, :minimum => 4, :too_short => "please enter at least 4 characters"
  validates_length_of :contacts, :minimum => 10, maximum:10, :allow_blank => false, too_short: "This should be 10 numbers"

  has_attached_file :cover,
                    styles: {medium: "1141x290", thumb: "400x400"}, default_url: "default_cover.png"


  has_attached_file :profile_img,
                    styles: {medium: "300x300", thumb: "200x200"}, default_url: "profile.jpg"

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


  def self.created_already?(email)
    print "email"
    puts email
    b = find_by_email(email[:email])
    if b
      true
    else
      false
    end
  end

  def self.from_omniauth(auth)

      where(provider: auth.provider, uid: auth.uid, email: auth.info.email ).first_or_initialize.tap do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.name = auth.info.name
        user.email = auth.info.email

        user.oauth_token = auth.credentials.token
        user.oauth_expires_at = Time.at(auth.credentials.expires_at)

        user.save!(:validate => false)
      # end
    end
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def generate_token
    self.token = loop do
      random_token = SecureRandom.hex(4)
      break random_token unless self.class.exists?(token: random_token)
    end
  end


end
