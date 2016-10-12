# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'User books a flight', js: true do
  before do
    create :airport
    create :route
  end

  scenario 'when there are flights available' do
    create(:flight_with_route, departure_date: Time.zone.now + 3600)
    search_for_flight
    select_flight

    expect(current_path).to eq('/bookings/new')

    fill_in_passenger_fields
    find_button('Book Now').click

    expect(current_path).to eq(confirm_booking_path(id: Booking.first.id))
  end

  scenario 'when there are no flights' do
    create(:flight_with_route, departure_date: Time.zone.now - 3600)
    search_for_flight

    expect(page.body).to include(no_flights_message)
    expect(current_path).to eq(home_path)
  end
end
