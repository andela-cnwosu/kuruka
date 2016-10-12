# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Paginate bookings', js: true do
  let(:user) { sign_in }
  
  before do
    load_flights
  end

  scenario 'with logged in user' do
    bookings = []
    params = { user: user, passenger_email: Faker::Internet.email }
    15.times do |_number|
      bookings << create(:booking, params)
    end
    visit bookings_path

    expect(page.body).to have_selector('div.pagination')
  end

  scenario 'with anonymous user' do
    visit bookings_path

    expect(page).to have_link('Sign In')
    expect(page).to have_content(require_login_message)
  end
end
