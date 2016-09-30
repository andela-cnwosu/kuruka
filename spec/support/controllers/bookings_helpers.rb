# frozen_string_literal: true
module Features
  module BookingHelpers
    def search_for_flight
      visit root_path
      find_button('Search').click
      choose('flight_id')
      find_button('Search Flight').click
    end
  end
end

RSpec.configure do |config|
  config.include Features::BookingHelpers, type: :feature
end
