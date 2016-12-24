class User < ActiveRecord::Base

  attr_accessor :password
  before_save :encrypt_password
  before_create :generate_token

  has_many :items
  has_and_belongs_to_many :time_slots, dependent: :destroy

  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :email, :name
  validates_uniqueness_of :email
  validates_length_of :password, :on => :create, :minimum => 4, :too_short => "please enter at least 4 characters"
  validates_length_of :contacts, :in => 3..12, :allow_blank => true # todo make range better boy

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
    # if created_already?(email:  auth.info.email)
    #   provider = auth.provider
    #   uid = auth.uid
    #   name = auth.info.name
    #   email = auth.info.email
    #
    #   oauth_token = auth.credentials.token
    #   oauth_expires_at = Time.at(auth.credentials.expires_at)
    #
    #   update!(provider: provider, uid: uid, name: name, oauth_expires_at: oauth_expires_at,
    #           oauth_token: oauth_token)
    # else
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
