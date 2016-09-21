require 'rails_helper'

RSpec.describe "bookings/new", type: :view do
  before(:each) do
    assign(:booking, Booking.new(
      :booking_ref => "MyString",
      :passenger => nil,
      :flight => nil,
      :checked_in => false
    ))
  end

  it "renders new booking form" do
    render

    assert_select "form[action=?][method=?]", bookings_path, "post" do

      assert_select "input#booking_booking_ref[name=?]", "booking[booking_ref]"

      assert_select "input#booking_passenger_id[name=?]", "booking[passenger_id]"

      assert_select "input#booking_flight_id[name=?]", "booking[flight_id]"

      assert_select "input#booking_checked_in[name=?]", "booking[checked_in]"
    end
  end
end
