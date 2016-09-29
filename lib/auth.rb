require "bcrypt"

class Auth
  def self.encrypt(password)
    BCrypt::Password.create(password)
  end

  def self.valid?(password, encrypted_password)
    BCrypt::Password.new(encrypted_password) == password
  end
end