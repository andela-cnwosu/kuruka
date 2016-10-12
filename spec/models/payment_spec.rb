# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Payment, type: :model do
  before do
    create :airport
    create :route
    create :flight
  end

  let :booking do
    create(:booking, user: create(:user, email: 'payer@gmail.com'))
  end

  subject :payment do
    create(:payment, booking: booking)
  end

  describe '#belongs_to' do
    it 'belongs to a booking' do
      expect(payment).to belong_to(:booking)
    end
  end

  describe '.paypal_url' do
    it 'returns a query string' do
      booking.update_attributes(booking_ref: '1A2B3C4D')
      expectation = '/cgi-bin/webscr?amount=&business=&cmd=_xclick&invoice=1A'\
        '2B3C4D&item_name=Flight+from+Abuja+to+Abuja&item_number=1A2B3C4D&not'\
        'ify_url=%2Fhook&quantity=1&return=path&upload=1'

      expect(Payment.paypal_url(booking, 'path')).to eql(expectation)
    end
  end
end
