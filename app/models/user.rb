class User < ApplicationRecord
  attr_accessor :remember_digest
  has_secure_password
  has_one :passenger
  has_many :bookings
  accepts_nested_attributes_for :passenger
  before_save :downcase_email
  before_save :generate_remember_token
  has_attached_file :avatar, 
                    styles: { :medium => "300x300>", :thumb => "100x100#" },
                    default_url: "/images/:style/avatar.jpg"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  validates :first_name,
            :last_name,
            :email,
            presence: true,
            allow_nil: false

  validates :email,
            format: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i,
            uniqueness: true

  validates :password,
            length: { minimum: 6 }

  def downcase_email
    self.email = self.email.downcase
  end

  def remember
    User.generate_remember_token
    update_attribute(:remember_digest, Auth.encrypt(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private
  
    def generate_remember_token
      self.remember_digest = SecureRandom.urlsafe_base64
    end
end
