class User < ApplicationRecord
  attr_accessor :remember_token
  
  has_secure_password
  has_one :passenger
  has_many :bookings
  accepts_nested_attributes_for :passenger
  before_save :downcase_email
  # before_save :generate_remember_token
  has_attached_file :avatar, 
                    styles: { :medium => "300x300>", :thumb => "100x100#" },
                    default_url: "/images/:style/avatar.jpg"

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  IMAGE_REGEX = /\Aimage\/.*\Z/

  validates_attachment_content_type :avatar, content_type: IMAGE_REGEX

  validates :first_name,
            :last_name,
            :email,
            presence: true,
            allow_nil: false

  validates :email,
            format: EMAIL_REGEX,
            uniqueness: true

  validates :password,
            length: { minimum: 6 },
            on: :create

  def full_name
    "#{first_name} #{last_name}"
  end

  def remember
    generate_remember_token
    update_attribute(:remember_digest, self.remember_token)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    Auth.valid?(remember_digest, Auth.encrypt(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def generate_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end

  def downcase_email
    self.email = self.email.downcase
  end
end
