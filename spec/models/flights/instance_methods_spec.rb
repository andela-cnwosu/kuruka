# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Flight, type: :model do
  before do
    create :airport
    create :route
    Flight.destroy_all
  end

  let! :flight do
    create :flight
  end

  describe '#search' do
    it 'searches for flights' do
      expect(flight.departure).to eql('Abuja')
    end
  end

  describe '#departure' do
    it 'returns the departure city for flight' do
      expect(flight.departure).to eql('Abuja')
    end
  end

  describe '#arrival' do
    it 'returns the arrival city for flight' do
      expect(flight.arrival).to eql('Abuja')
    end
  end

  describe '#name' do
    it 'returns the name of the aircraft' do
      expect(flight.name).to eql('5N-3HD5')
    end
  end

  describe '#route_airports' do
    it 'returns the departure and arrival airport name' do
      expect(flight.route_airports)
        .to eql('Nnamdi Azikiwe Airport to Nnamdi Azikiwe Airport')
    end
  end

  describe '#departed?' do
    it 'returns true' do
      departed_flight = create :departed_flight
      expect(departed_flight.departed?).to eql(true)
    end
  end
end
