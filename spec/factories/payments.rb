# frozen_string_literal: true
FactoryGirl.define do
  factory :payment do
    payment_date Time.zone.now
    transaction_ref '1234ABCD'
    status 1
    booking
  end
end
