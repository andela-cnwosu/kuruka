class BookingsController < ApplicationController
  before_action :set_booking, only: [:edit, :update, :destroy, :confirmation]
  before_action :set_user
  before_action :require_login, only: [:edit, :update, :index]

  def index
    @bookings = current_user.bookings.
    paginate(page: params[:page], per_page: 10).
    order(created_at: :desc) if current_user
  end

  def select
    flight = Flight.find(id: params[:flight_id])
    passenger_count = session[:passenger_count]
    redirect_to new_booking_path flight: flight, passengers: passenger_count
  end

  def new
    @booking = Booking.new
    @booking.flight = Flight.find_by id: params[:flight]
    @passenger_count = params[:passengers]
  end

  def retrieve
    @booking = Booking.find_by(search_params)
    locals = { booking: @booking }
    if @booking
      (render partial: 'bookings/booking_details', locals: locals) && return
    end
    respond_message "danger", no_booking_found_message(search_params)
  end

  def create
    booking = Booking.new(booking_params)
    booking.set_total_cost
    (confirm_booking booking if booking.save) || (show_booking_error booking)
  end

  def confirm_booking(booking)
    clear_passenger_count
    send_booking_mail booking
    redirect_to Payment.paypal_url(booking, hook_path)
  end

  def show_booking_error(booking)
    flash_model_error_message booking
    redirect_back fallback_location: new_booking_path
  end

  def update
    @booking.set_total_cost
    if @booking.update booking_params
      confirm_update @booking
    else
      flash_model_error_message @booking
    end
    redirect_back fallback_location: edit_booking_path
  end

  def confirm_update(booking)
    flash_message :success, booking_update_success_message
    send_booking_update_mail booking 
  end

  def destroy
    @booking.destroy
    redirect_back fallback_location: bookings_path
  end

  def send_booking_mail(booking)
    KurukaMailer.booking_email(booking).deliver_now
  end

  def send_booking_update_mail(booking)
    KurukaMailer.booking_updated_email(booking).deliver_now
  end

  private

  def set_booking
    @booking = Booking.find_by id: params[:id]
  end

  def booking_params
    params.require(:booking).permit(
      :flight_id, :user_id, :cost_in_dollar, :passenger_email,
      passengers_attributes:[
        :id, :first_name, :last_name, :phone, :_destroy, :airfare_id
      ]
    )
  end

  def search_params
    params.require(:booking).permit(:booking_ref)
  end
end
