class Booking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :flight

  has_many :passengers, dependent: :destroy
  has_one :payment
  
  before_create :set_booking_ref
  
  accepts_nested_attributes_for :passengers,
                                reject_if: :all_blank,
                                allow_destroy: true

  def set_booking_ref
    self.booking_ref = SecureRandom.hex(4).upcase
  end

  def departure
    flight.departure
  end

  def arrival
    flight.arrival
  end

  def departure_date
    flight.departure_date
  end

  def route_name
    flight.route_name
  end

  def passengers_names
    passengers.map(&:full_name).join(", ")
  end

  def set_total_cost
    cost = 0
    passengers.each { |passenger| cost += passenger.fare }
    self.cost_in_dollar = "%.2f" % cost
  end

  def decorated_flight
    FlightDecorator.new(flight)
  end

  def user_email
    user ? user.email : passenger_email
  end

  def user_first_name
    user ? user.first_name : user_email[/[^@]+/]
  end
end
