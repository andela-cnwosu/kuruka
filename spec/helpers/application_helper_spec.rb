# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe ApplicationHelper do
    before :all do
      create :airport
      create :route
      create :flight
    end

    let :booking do
      create :booking
    end

    describe '#get_booking_cost' do
      context 'when booking cost is nil' do
        it 'returns 0.00' do
          expect(helper.get_booking_cost(booking)).to eq('0.00')
        end
      end

      context 'when booking cost has a value' do
        it 'returns the booking cost' do
          booking.cost_in_dollar = '123.45'
          booking.save
          expect(helper.get_booking_cost(booking)).to eq(123.45)
        end
      end
    end

    describe '#pack' do
      it 'removes spaces from a string' do
        expect(helper.pack('first class ')).to eq('firstclass')
      end
    end
  end
end
