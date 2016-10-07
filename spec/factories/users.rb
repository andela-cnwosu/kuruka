# frozen_string_literal: true
FactoryGirl.define do
  factory :user do
    first_name 'Chineze'
    last_name 'Nwosu'
    email 'user@gmail.com'
    password Auth.encrypt('password')
    remember_digest SecureRandom.urlsafe_base64
    avatar { File.new("#{Rails.root}/spec/support/fixtures/test_image.png") }
  end

  factory :new_user do
    first_name 'Chinese'
    last_name 'Benny'
    email 'newuser@gmail.com'
    password 'password'
    password_confirmation 'password'
  end
end
