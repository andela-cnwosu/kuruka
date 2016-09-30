# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Airfare, type: :model do
  before do
    @country = create(:country)
    create :airport
    create :route
    create :flight
    @airfare = create :airfare
  end

  describe '#belong_to' do
    it 'belongs to a travel class' do
      expect(@airfare).to belong_to(:travel_class)
    end
  end

  describe '#belong_to' do
    it 'belongs to route' do
      expect(@airfare).to belong_to(:route)
    end
  end

  describe '#has_many' do
    it 'has many passengers' do
      expect(@airfare).to have_many(:passengers)
    end
  end

  describe '#service_charge_in_currency' do
    it 'returns a converted charge' do
      charge = @airfare.service_charge_in_currency(@country)
      expect(charge).to equal(315_000.0)
    end
  end

  describe '#total_fare_in_dollar' do
    it 'returns the total fare in dollar' do
      expect(@airfare.total_fare_in_dollar).to equal(1100.0)
    end
  end

  describe '#total_fare_in_currency' do
    it 'returns the total fare in converted charge' do
      charge = @airfare.total_fare_in_currency(@country)
      expect(charge.to_f).to equal(346_500.0)
    end
  end
end
