require 'rails_helper'

RSpec.describe Flight, type: :model do
  let(:flight) do
    {
      departure_date: Time.zone.now + 86_400 * 10,
      arrival_date: Time.zone.now + 86_400 * 11,
      aircraft_id: 1,
      route_id: 1
    }
  end

  before do
    create(:airport)
    create(:route)
    @flight = create :flight
  end

  describe "#has_many" do
    it "has many bookings" do
      expect(@flight).to have_many(:bookings)
    end
  end

  describe "#belongs_to" do
    it "belongs to a aircraft" do
      expect(@flight).to belong_to(:aircraft)
    end
  end

  describe "#belongs_to" do
    it "belongs to a route" do
      expect(@flight).to belong_to(:route)
    end
  end

  describe "#search" do
    it "searches for flights" do
      expect(@flight.departure).to eql("Abuja")
    end
  end

  describe "#departure" do
    it "returns the departure city for flight" do
      expect(@flight.departure).to eql("Abuja")
    end
  end

  describe "#arrival" do
    it "returns the arrival city for flight" do
      expect(@flight.arrival).to eql("Abuja")
    end
  end

  describe ".top_recent" do
    it "returns the first 4 flights" do
      expect(Flight.top_recent).to include(@flight)
    end
  end

  describe ".next_recent" do
    context "when there are less than or equal to 4 flights" do
      it "returns 0 count" do
        expect(Flight.next_recent.count).to eql(0)
      end
    end

    context "when there are up to 8 flights" do
      it "returns 4 flights" do
        8.times do |number|
          create :flight
        end
        expect(Flight.next_recent.count).to eql(4)
      end
    end
  end

  describe ".last_by_date" do
    it "returns the last flight" do
      new_flight = Flight.create flight
      expect(Flight.last_by_date).to eql(new_flight)
    end
  end

  describe ".include_joins" do
    context "when flight is eager loaded" do
      it "eager loads its foreign key attributes" do
        loaded_flight = Flight.include_joins.first
        expect(loaded_flight.association(:route).loaded?).to eql(true)
      end
    end

    context "when flight is not eager loaded" do
      it "eager loads its foreign key attributes" do
        flight = Flight.first
        expect(flight.association(:route).loaded?).to eql(false)
      end
    end
  end

  describe "#name" do
    it "returns the name of the aircraft" do
      expect(@flight.name).to eql('5N-3HD5')
    end
  end

  describe "#route_airports" do
    it "returns the departure and arrival airport name" do
      expect(@flight.route_airports).
        to eql('Nnamdi Azikiwe Airport to Nnamdi Azikiwe Airport')
    end
  end

  describe "#departed?" do
    it "returns true" do
      @departed_flight = create :departed
      expect(@departed_flight.departed?).to eql(true)
    end
  end

  describe "#instance_methods" do
    it "responds to name" do
      expect(@flight).to respond_to(:name)
    end

    it "responds to arrival" do
      expect(@flight).to respond_to(:arrival)
    end

    it "responds to departure" do
      expect(@flight).to respond_to(:departure)
    end
  end

  describe ".class_methods" do
    it "responds to include_joins" do
      expect(Flight).to respond_to(:include_joins)
    end

    it "responds to search" do
      expect(Flight).to respond_to(:search)
    end

    it "responds to search_by_current" do
      expect(Flight).to respond_to(:search_by_current)
    end

    it "responds to search_by_params" do
      expect(Flight).to respond_to(:search_by_params)
    end

    it "responds to by_day" do
      expect(Flight).to respond_to(:by_day)
    end

    it "responds to uniq_departure_dates" do
      expect(Flight).to respond_to(:uniq_departure_dates)
    end
  end
end
