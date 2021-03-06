# frozen_string_literal: true
module ApplicationHelper
  def pack(str)
    str.to_s.delete(' ')
  end

  def get_booking_cost(booking)
    booking.cost_in_dollar || '0.00'
  end
end
