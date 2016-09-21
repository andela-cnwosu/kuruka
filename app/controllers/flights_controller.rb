class FlightsController < ApplicationController
  def search
    @flights = Flight.search(reject_empty!(search_params.slice(:routes)))
    set_passenger_count
    render partial: 'flights/search_results', locals: {
        flights: (FlightDecorator.new(@flights) if @flights) || nil,
        depart_date: search_params[:departure_date]
    }
  end

  def reject_empty!(value_params)
    value_params.delete_if {|key, value| value.blank? }
    value_params.values.each do |value|
      reject_empty!(value) if value.is_a?(ActionController::Parameters)
    end
    value_params.delete_if {|key, value| value.blank? }
  end

  private
    
  def search_params
    params.require(:flight_search).permit(
      :departure_date,
      routes: [:departure_airport_id, :arrival_airport_id]
    )
  end
end
