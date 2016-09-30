# frozen_string_literal: true
class Airfare < ApplicationRecord
  belongs_to :travel_class
  belongs_to :route
  has_many :passengers

  def service_charge_in_currency(country)
    (service_charge_in_dollar * country.exchange_rate.to_i).to_f
  end

  def total_fare_in_dollar
    (service_charge_in_dollar * travel_class.tax_percent).to_f
  end

  def total_fare_in_currency(country)
    (service_charge_in_currency(country) * travel_class.tax_percent).to_f
  end
end
