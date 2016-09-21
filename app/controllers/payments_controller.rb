class PaymentsController < ApplicationController
  protect_from_forgery except: [:hook]
  
  def hook
    params.permit!
    status = params[:payment_status]
    if status == "Completed"
      response = validate_ipn_notification(request.raw_post)
      examine_booking(response)
    end
    redirect_to bookings_path
  end

  def create_payment_and_redirect 
    Payment.create(booking: @booking,
        status: :successful,
        transaction_ref: params[:txn_id],
        payment_date: Time.now)
    redirect_to booking_confirmation_path(@booking)
  end

  def validate_ipn_notification(raw)
    uri = URI.parse(Payment.validate_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.open_timeout = 60
    http.read_timeout = 60
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    http.post(uri.request_uri, raw,
              "Content-Length" => raw.size.to_s,
              "User-Agent" => "Kuruka").body
  end

  def examine_booking(response)
    case response
    when "VERIFIED"
      @booking = Booking.find_by_booking_ref(params[:invoice])
      create_payment_and_redirect if @booking
    when "INVALID"
    end
  end
end
