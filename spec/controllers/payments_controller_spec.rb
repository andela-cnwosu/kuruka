# frozen_string_literal: true
require 'rails_helper'

RSpec.describe PaymentsController, type: :controller do
  before do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'POST #hook' do
    context 'when payment status is complete' do
      it 'redirects to confirm bookings path' do
        booking = create :booking
        booking.booking_ref = '1234ABCD'
        booking.save
        post :hook, params: {
          payment_status: 'Completed', invoice: '1234ABCD', booking: booking
        }
        expect(response).to redirect_to confirm_booking_path(booking)
      end
    end

    context 'when status is not complete' do
      it 'redirects to new bookings path' do
        post :hook
        expect(response).to redirect_to new_booking_path
      end
    end
  end
end
