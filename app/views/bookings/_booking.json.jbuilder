json.extract! booking, :id, :booking_ref, :passenger_id, :flight_id, :checked_in, :created_at, :updated_at
json.url booking_url(booking, format: :json)