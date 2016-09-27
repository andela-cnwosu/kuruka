FactoryGirl.define do
  factory :user do
    first_name "Chineze"
    last_name "Nwosu"
    email "user@gmail.com"
    password Auth.encrypt("password")
    remember_digest SecureRandom.urlsafe_base64
    avatar { File.new("#{Rails.root}/spec/support/fixtures/test_image.png") } 
  end
end
