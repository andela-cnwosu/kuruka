# frozen_string_literal: true
require 'rails_helper'
require 'support/features/users_helpers'

RSpec.feature 'User logs in', js: true do
  before do
    load_flights
    create(:user, email: 'user@gmail.com', password: 'password')
  end

  scenario 'with valid email and password' do
    sign_in_with('user@gmail.com', 'password')

    expect_user_to_be_signed_in
  end

  scenario 'with invalid password' do
    sign_in_with('user@gmail.com', 'paSSword')

    expect_invalid_login_error
  end

  scenario 'with invalid email' do
    sign_in_with('wrong_user@gmail.com', 'password')

    expect_invalid_login_error
  end

  scenario 'with invalid email and invalid password' do
    sign_in_with('wrong_user@gmail.com', 'wrong_password')

    expect_invalid_login_error
  end
end
