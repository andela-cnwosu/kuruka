# frozen_string_literal: true
FactoryGirl.define do
  factory :booking do
    flight
    user
    passenger_email 'passenger@gmail.com'
  end
end
