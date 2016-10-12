# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'User manages a booking', js: true do
  before do
    load_flights
  end

  let! :booking do
    create(
      :booking,
      user: nil,
      passengers: [create(:passenger)],
      flight: @flight
    )
  end

  scenario 'when the booking reference exists' do
    find_booking_by_ref(booking.booking_ref)
    find_link(booking.passengers.first.full_name)

    expect(current_path).to eq(manage_bookings_path)
    expect(page.body).to include(booking.passengers.first.full_name)
    expect(page.body).to have_link('Edit Reservation')
  end

  scenario 'when the booking reference does not exist' do
    find_booking_by_ref('WRONGREF')

    expect(current_path).to eq(manage_bookings_path)
    expect(page.body).to include('There is no booking with reference number')
    expect(page.body).not_to have_link('Edit Reservation')
  end

  scenario 'when the flight has departed' do
    Booking.destroy_all
    booking = create_booking_with_flight create(:departed_flight)
    find_booking_by_ref(booking.booking_ref)
    find_link(booking.passengers.first.full_name)

    expect(current_path).to eq(manage_bookings_path)
    expect(page.body).to include(booking.passengers.first.full_name)
    expect(page.body).not_to have_link('Edit Reservation')
  end
end
