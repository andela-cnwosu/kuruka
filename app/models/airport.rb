class Airport < ApplicationRecord
  belongs_to :state
  has_many :departure_routes, class_name: "Route", foreign_key: :departure_airport_id
  has_many :arrival_routes, class_name: "Route", foreign_key: :arrival_airport_id

  def iata_name
    "#{self.city} (#{self.iata_code})"
  end
end
