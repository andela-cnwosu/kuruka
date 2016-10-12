# frozen_string_literal: true
module Features
  module BookingHelpers
    def load_flights
      create :airport
      @flight = create(:flight_with_route, departure_date: Time.zone.now + 3600)
    end

    def search_for_flight
      visit root_path
      find_button('Search').click
    end

    def select_flight
      find('.control-indicator', match: :first).click
      find_button('Select Flight').click
    end

    def find_booking_by_ref(booking_reference)
      visit manage_bookings_path
      fill_in('booking[booking_ref]', with: booking_reference)
      find_button('Find Reservation').click
    end

    def fill_in_passenger_fields
      within '.nested-fields' do
        find('input[placeholder="* First Name"]').set(Faker::Name.first_name)
        find('input[placeholder="* Last Name"]').set(Faker::Name.last_name)
        find('input[placeholder="Phone"]').set('08000000000')
        find('.control-indicator', match: :first).click
      end
      fill_in 'booking[passenger_email]', with: Faker::Internet.email
    end

    def create_booking_with_flight(flight)
      passengers = [create(:passenger)]
      create(:booking, user: nil, passengers: passengers, flight: flight)
    end
  end
end
