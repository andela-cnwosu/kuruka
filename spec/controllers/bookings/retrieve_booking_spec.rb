# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'POST #retrieve' do
    context 'when booking reference exists' do
      before do
        booking_to_find = { booking_ref: create(:booking).booking_ref }
        post(:retrieve, params: { booking: booking_to_find })
      end

      it 'returns a status of 200' do
        expect(controller).to respond_with(:ok)
      end

      it 'returns the booking details' do
        expect(response).to render_template(
          partial: 'bookings/_booking_details'
        )
      end
    end

    context 'when booking reference does not exist' do
      it 'return an error message' do
        booking_to_find = { booking_ref: 'WRONGREF' }
        post(:retrieve, params: { booking: booking_to_find })
        expect(response).to render_template(partial: 'application/_message')
      end
    end
  end
end
