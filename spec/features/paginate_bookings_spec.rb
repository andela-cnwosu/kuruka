# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Paginate bookings', js: true do
  let(:user) { sign_in }

  before do
    load_flights
  end

  scenario 'with logged in user' do
    params = { user: user, passenger_email: Faker::Internet.email }
    create_list(:booking, 15, params)
    visit bookings_path

    expect(page.body).to have_selector('div.pagination')
  end

  scenario 'with anonymous user' do
    visit bookings_path

    expect(page).to have_link('Sign In / Sign Up')
    expect(page).to have_content(require_login_message)
  end
end
