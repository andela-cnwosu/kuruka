require "rails_helper"
require "support/features/users_helpers"

RSpec.feature "User logs in" do
  before(:all) do
    create_user "user@gmail.com", "password"
    create(:airport)
    create(:route)
    create(:flight)
  end

  scenario "with valid email and password" do
    sign_in_with "user@gmail.com", "password"

    expect_user_to_be_signed_in
  end

  scenario "with valid mixed-case email and password " do
    sign_in_with "USER@gmail.com", "password"

    expect_user_to_be_signed_in
  end

  scenario "with invalid password" do
    sign_in_with "user@gmail.com", "paSSword"

    expect_invalid_param_error('password')
  end

  scenario "with invalid email" do
    sign_in_with "wrong_user@gmail.com", "password"

    expect_invalid_param_error('email')
  end

  scenario "with invalid email and invalid password" do
    sign_in_with "wrong_user@gmail.com", "wrong_password"

    expect_invalid_param_error('email')
  end

  private

    def create_user(email, password)
      create(:user, email: email, password: password)
    end
end
