# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Flight, type: :model do
  before do
    create :airport
    create :route
    Flight.destroy_all
    @flight = create :flight
  end

  describe '.top_recent' do
    it 'returns the first 4 flights' do
      expect(Flight.top_recent).to include(@flight)
    end
  end

  describe '.next_recent' do
    context 'when there are less than or equal to 4 flights' do
      it 'returns 0 count' do
        expect(Flight.next_recent.count).to eql(0)
      end
    end

    context 'when there are up to 8 flights' do
      it 'returns 4 flights' do
        8.times do |_number|
          create :flight
        end
        expect(Flight.next_recent.count).to eql(4)
      end
    end
  end

  describe '.last_by_date' do
    it 'returns the last flight' do
      new_flight = create :new_flight
      expect(Flight.last_by_date).to eql(new_flight)
    end
  end

  describe '.include_joins' do
    context 'when flight is eager loaded' do
      it 'eager loads its foreign key attributes' do
        loaded_flight = Flight.include_joins.first
        expect(loaded_flight.association(:route).loaded?).to eql(true)
      end
    end

    context 'when flight is not eager loaded' do
      it 'eager loads its foreign key attributes' do
        flight = Flight.first
        expect(flight.association(:route).loaded?).to eql(false)
      end
    end
  end

  describe '.search_by_current' do
    before do
      @flight = create :flight
      @departed_flight = create :departed
    end

    it 'returns flights that have not departed' do
      expect(Flight.search_by_current).to include(@flight)
    end

    it 'does not return flights that have departed' do
      expect(Flight.search_by_current).not_to include(@departed_flight)
    end
  end

  describe '.search_by_params' do
    it 'returns flights according to search parameters' do
      create :airport
      create(:route, departure_airport_id: 2)
      flight = create :flight, route_id: 2
      search_params = { route: [2, 1] }
      expect(Flight.search_by_params(search_params)).to include(flight)
    end
  end

  describe '.by_day' do
    it 'returns all flights in a particular day' do
      flight = create :flight, departure_date: Time.now + 3600
      expect(Flight.by_day(Time.now)).to include(flight)
    end

    it 'does not return flights that do not take off on given date' do
      expect(Flight.by_day(Time.now)).not_to include(@flight)
    end
  end

  describe '.departure_order_asc' do
    it 'returns an array of dates' do
      expect(Flight.departure_order_asc).to be_a_kind_of(Array)
    end
  end

  describe '.uniq_departure_dates' do
    it 'returns an array of dates' do
      expect(Flight.uniq_departure_dates).to be_a_kind_of(Array)
    end
  end
end
