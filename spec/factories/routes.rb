# frozen_string_literal: true
FactoryGirl.define do
  factory :route do
    name 'ABV-ENU'
    departure_airport_id 1
    arrival_airport_id 1

    factory :route_with_airfares do
      after(:create) do |route|
        route.airfares << create_list(:airfare, 3)
      end
    end
  end
end
