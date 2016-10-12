# frozen_string_literal: true
module MessagesHelpers
  def invalid_login_message
    'Your login information is incorrect'
  end

  def require_login_message
    'You must be logged in to access this section.'
  end

  def no_flights_message
    'There are currently no flights scheduled for the year for this search. '\
    'Please check back later.'
  end

  def booking_update_success_message
    'Your reservation was successfully updated.'
  end

  def updated_user_message
    'Your profile has been updated successfully.'
  end
end
