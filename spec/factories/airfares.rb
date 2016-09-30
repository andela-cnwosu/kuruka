# frozen_string_literal: true
FactoryGirl.define do
  factory :airfare do
    service_charge_in_dollar 1000.00
    route
    travel_class
  end
end
