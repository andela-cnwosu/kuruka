class Flight < ApplicationRecord
  belongs_to :aircraft
  belongs_to :route
  has_many :bookings
  accepts_nested_attributes_for :route

  def self.search(params)
    params.blank? ? search_by_current : search_by_params(params)
  end

  def self.search_by_current
    include_flight.where("departure_date > ?", Time.now)
  end

  def self.search_by_params(search_params)
    include_flight.
      where(search_params).
      where("departure_date > ?", Time.now)
  end

  def self.recent
    order(:departure_date).where("departure_date > ?", Time.now)
  end

  def self.top_recent
    recent.first(4)
  end

  def self.next_recent
    recent.offset(4).first(4)
  end

  def self.departure_date_range
    (Date.today..last.departure_date)
  end

  def self.departure_order_asc
    order(:departure_date).pluck(:departure_date).uniq
  end

  def self.last
    order(:departure_date).last
  end

  def self.include_flight
    includes(
      route: [:departure_airport, :arrival_airport, airfares: [:travel_class]]
    )
  end

  def departed?
    departure_date < Time.now
  end

  def name
    aircraft.tail_number
  end

  def departure
    route.departure_airport.city
  end

  def arrival
    route.arrival_airport.city
  end

  def route_name
    "#{departure} to #{arrival}"
  end

  def route_airports
    "#{route.departure_airport.name} to #{route.arrival_airport.name}"
  end
end
