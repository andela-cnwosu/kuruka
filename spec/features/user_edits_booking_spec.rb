# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'User edits bookings', js: true do
  before do
    load_flights
  end

  let! :booking do
    create(
      :booking,
      user: nil,
      flight: @flight,
      passengers: [create(:passenger)]
    )
  end

  scenario 'with valid credentials' do
    visit edit_booking_path(booking)

    expect(page.body).to have_button('Update Reservation')

    fill_in_passenger_fields
    find_button('Update Reservation').click

    expect(current_path).to eq(edit_booking_path(booking))
    expect(page.body).to include(booking_update_success_message)
  end
end
