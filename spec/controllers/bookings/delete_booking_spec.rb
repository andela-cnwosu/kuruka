# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'DELETE #destroy' do
    before do
      session[:user_id] = 1
      @booking = create :booking
    end

    it 'destroys the requested booking' do
      expect { delete(:destroy, params: { id: @booking.id }) }
        .to change(Booking, :count).by(-1)
    end

    it 'redirects to the bookings list' do
      delete(:destroy, params: { id: @booking.id })
      expect(response).to redirect_to(bookings_path)
    end
  end
end
