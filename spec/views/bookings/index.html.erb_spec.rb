require 'rails_helper'

RSpec.describe "bookings/index", type: :view do
  before(:each) do
    assign(:bookings, [
      Booking.create!(
        :booking_ref => "Booking Ref",
        :passenger => nil,
        :flight => nil,
        :checked_in => false
      ),
      Booking.create!(
        :booking_ref => "Booking Ref",
        :passenger => nil,
        :flight => nil,
        :checked_in => false
      )
    ])
  end

  it "renders a list of bookings" do
    render
    assert_select "tr>td", :text => "Booking Ref".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
