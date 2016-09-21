require "rails_helper"
require "support/features/users_helpers"

RSpec.feature "User signs up" do
  scenario "by navigating to the page" do
    visit root_path

    expect(page).to have_content "Sign In"
  end

  scenario "with valid email and password" do
    sign_up_with "Jane", "Doe", "user@gmail.com", "password", "password"

    expect_user_to_be_signed_in
  end

  scenario "tries with invalid email" do
    sign_up_with "Jane", "Doe", "invalid_email", "password", "password"

    expect_user_to_be_signed_out
  end

  scenario "tries with blank password" do
    sign_up_with "Jane", "Doe", "valid@example.com", "", ""

    expect_user_to_be_signed_out
  end
end
