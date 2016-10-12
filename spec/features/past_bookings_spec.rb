# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'User views past bookings', js: true do
  let!(:flight) { load_flights }
  let!(:user) { sign_in }

  before do
    visit bookings_path
  end

  scenario 'when reservations were made in the past' do
    create(:booking, user: user)
    visit bookings_path

    expect(page.body).to include('You made 1 reservation in the past.')
    expect(page.body).to have_selector('table')
    expect(page.body).to include(Booking.first.booking_ref)
  end

  scenario 'when no reservations were made in the past' do
    visit bookings_path

    expect(page.body).to include('You made 0 reservations in the past.')
    expect(page.body).not_to have_selector('table')
  end

  scenario 'when booked flight has already departed' do
    departed_flight = create(:departed_flight)
    create(:booking, user: user, flight: departed_flight)
    visit bookings_path

    expect(page.body).not_to have_link('Edit')
    expect(page.body).not_to have_link('Cancel')
  end
end
