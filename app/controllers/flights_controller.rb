# frozen_string_literal: true
class FlightsController < ApplicationController
  def search
    @flights = Flight.search reject_empty_routes
    set_passenger_count
    render partial: 'flights/search_results', locals: {
      flights: decorated_flights,
      depart_date: search_params[:departure_date]
    }
  end

  def reject_empty(value_params)
    value_params.delete_if { |_key, value| value.blank? }
    value_params.values.each do |value|
      reject_empty(value) if value.is_a?(ActionController::Parameters)
    end
    value_params.delete_if { |_key, value| value.blank? }
  end

  def reject_empty_routes
    reject_empty(search_params.slice(:routes))
  end

  def decorated_flights
    (FlightDecorator.new(@flights) if @flights) || nil
  end

  private

  def search_params
    params.require(:flight_search).permit(
      :departure_date,
      routes: [:departure_airport_id, :arrival_airport_id]
    )
  end
end
