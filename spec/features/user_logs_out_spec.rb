# frozen_string_literal: true
require 'rails_helper'
require 'support/features/users_helpers'

RSpec.feature 'User logs out' do
  before do
    create :airport
    create :route
    create :flight
  end

  scenario 'by clicking log out link' do
    sign_in
    sign_out

    expect_user_to_be_signed_out
  end
end
