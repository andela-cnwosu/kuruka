class FlightsController < ApplicationController
  def search
    @flights = Flight.search(reject_empty!(search_params.slice(:routes)))
    set_passenger_count
    respond_partial('flights/search_results', {
      flights: FlightDecorator.new(@flights),
      depart_date: search_params[:departure_date]
    })
  end

  def reject_empty!(value_params)
    value_params.delete_if {|key, value| value.blank? }
    value_params.values.each do |v|
      reject_empty!(v) if v.is_a?(ActionController::Parameters)
    end
    value_params.delete_if {|key, value| value.blank? }
  end

  def set_passenger_count
    passenger_count = params[:passenger_count]
    session[:passenger_count] = passenger_count.blank? ? 1 : passenger_count
  end

  private
    
    def search_params
      params.require(:flight_search).permit(
        :departure_date,
        routes: [:departure_airport_id, :arrival_airport_id]
      )
    end
end
