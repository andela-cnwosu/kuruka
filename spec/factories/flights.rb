# frozen_string_literal: true
FactoryGirl.define do
  factory :flight do
    departure_date Time.zone.now + 86_400
    arrival_date Time.zone.now + 86_400 * 7
    aircraft
    route

    factory :departed_flight do
      departure_date Time.zone.now - 86_400
    end

    factory :new_flight do
      departure_date Time.zone.now + 86_400 * 10
      arrival_date Time.zone.now + 86_400 * 11
    end

    factory :flight_with_route do
      after(:create) do |flight|
        create(:route_with_airfares, flights: [flight])
      end
    end
  end
end
