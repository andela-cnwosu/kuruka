# frozen_string_literal: true
class PaymentsController < ApplicationController
  protect_from_forgery except: [:hook]

  def hook
    params.permit!
    status = params[:payment_status]
    if status == 'Completed'
      create_payment_and_redirect
      return
    end
    redirect_back(fallback_location: new_booking_path)
  end

  def create_payment_and_redirect
    @booking = Booking.find_by(booking_ref: params[:invoice])
    Payment.create(
      booking: @booking,
      status: :successful,
      transaction_ref: params[:txn_id],
      payment_date: Time.now
    )
    redirect_to confirm_booking_path(@booking)
  end
end
