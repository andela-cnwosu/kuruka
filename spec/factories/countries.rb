# frozen_string_literal: true
FactoryGirl.define do
  factory :country do
    name 'Nigeria'
    country_code '+234'
    currency 'Naira'
    iso_currency 'NGN'
    exchange_rate 315
  end
end
