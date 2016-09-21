require 'rails_helper'

RSpec.describe "bookings/show", type: :view do
  before(:each) do
    @booking = assign(:booking, Booking.create!(
      :booking_ref => "Booking Ref",
      :passenger => nil,
      :flight => nil,
      :checked_in => false
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Booking Ref/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/false/)
  end
end
