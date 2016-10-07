# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Paginate bookings', js: true do
  before do
    create :airport
    create :route
    create :flight
    @user = create(:user, email: 'user@gmail.com', password: 'password')
  end

  scenario 'with logged in user' do
    sign_in_with('user@gmail.com', 'password')
    bookings = []
    params = { user: @user, passenger_email: Faker::Internet.email }
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