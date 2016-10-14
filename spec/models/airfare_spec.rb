# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Airfare, type: :model do
  before do
    create :airport
    create :route
    create :flight
  end

  subject :airfare do
    create :airfare
  end

  let :country do
    create :country
  end

  describe 'associations' do
    it 'belongs to a travel class' do
      expect(airfare).to belong_to(:travel_class)
    end
    
    it 'belongs to route' do
      expect(airfare).to belong_to(:route)
    end

    it 'has many passengers' do
      expect(airfare).to have_many(:passengers)
    end
  end

  describe '#service_charge_in_currency' do
    it 'returns a converted charge' do
      charge = airfare.service_charge_in_currency(country)
      expect(charge).to equal(315_000.0)
    end
  end

  describe '#total_fare_in_dollar' do
    it 'returns the total fare in dollar' do
      expect(airfare.total_fare_in_dollar).to equal(1100.0)
    end
  end

  describe '#total_fare_in_currency' do
    it 'returns the total fare in converted charge' do
      charge = airfare.total_fare_in_currency(country)
      expect(charge.to_f).to equal(346_500.0)
    end
  end
end
