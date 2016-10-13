# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'User edits profile', js: true do
  let!(:flight) { load_flights }
  let!(:user) { sign_in }

  before do
    visit user_home_path
  end

  scenario 'with valid credentials' do
    visit user_profile_path
    fill_in 'user[first_name]', with: 'Jane'
    fill_in 'user[last_name]', with: 'Doe'
    fill_in 'user[email]', with: 'updated_user@gmail.com'

    find_button('Update Account').click

    updated_user = User.find_by(id: user.id)

    expect(page.body).to include(updated_user_message)
    expect(updated_user.email).to eq('updated_user@gmail.com')
  end
end
