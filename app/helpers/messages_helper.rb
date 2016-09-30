# frozen_string_literal: true
module MessagesHelper
  def log_out_message
    'You have been logged out successfully.'
  end

  def log_in_message
    'You have been logged in successfully.'
  end

  def flash_message(status, message)
    flash[status] = message
  end

  def no_flights_for_day_message
    'There are currently no flights for this date. '\
    'This flight is only available on:'
  end

  def no_flights_message
    'There are currently no flights scheduled for the year for this search. '\
    'Please check back later.'
  end

  def updated_user_message
    'Your profile has been updated successfully.'
  end

  def require_login_message
    'You must be logged in to access this section.'
  end

  def confirmed_booking_message
    'Your details are shown below. This has also been sent to your email.'
  end

  def confirmed_past_booking_message
    'This ticket is no longer in use.'
  end

  def booking_mail_subject_message
    'Kuruka Booking Confirmed!'
  end

  def booking_update_mail_subject_message
    'Kuruka Booking Updated!'
  end

  def contact_mail_subject_message
    'Kuruka Contact Message'
  end

  def contact_success_message
    'Thank you for contacting us. We will get back to you as soon as possible'
  end

  def no_booking_found_message(booking_param)
    "There is no booking with reference number '#{booking_param[:booking_ref]}'"
  end

  def booking_update_success_message
    'Your reservation was successfully updated.'
  end

  def full_error_message(model)
    model.errors.full_messages.join('<br>')
  end

  def flight_departed_message
    'This action cannot be done because the flight has already departed'
  end

  def no_bookings_message
    'You do not have any past bookings. '\
    'Please visit your home page to make a reservation.'
  end

  def invalid_field_message(field)
    "Your #{field} is incorrect"
  end

  def invalid_login_message
    'Your login information is incorrect'
  end

  def flash_model_error_message(model)
    flash_message(:error, full_error_message(model))
  end
end
