require "bcrypt"

class Auth
  def self.encrypt(password)
    BCrypt::Password.create(password)
  end

  def self.valid?(password, encrypted_password)
    password.eql? BCrypt::Password.new(encrypted_password)
  end
end