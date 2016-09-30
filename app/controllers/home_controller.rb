# frozen_string_literal: true
class HomeController < ApplicationController
  before_action :set_user
  before_action :set_flights, only: [:schedule]

  def root
    (redirect_to user_home_path if current_user) || (redirect_to home_path)
  end

  private

  def set_flights
    @flights = Flight.include_joins
  end
end
