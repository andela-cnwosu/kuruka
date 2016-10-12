# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let :new_booking do
    {
      flight_id: Flight.first.id,
      passenger_email: Faker::Internet.email,
      passengers_attributes: [{
        first_name: 'Chinese',
        last_name: 'Benny',
        phone: '08012345678',
        airfare_id: 1
      }]
    }
  end

  let :booking do
    create :booking
  end

  before :all do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'PUT #update' do
    before do
      new_booking[:passengers_attributes] << {
        first_name: 'China',
        last_name: 'Ben',
        phone: '09000000000',
        airfare_id: 2
      }
      put(:update, params: { id: booking.id, booking: new_booking })
    end

    context 'when booking update fails' do
      it 'returns a flash error message' do
        new_booking[:passenger_email] = 'wrong_email'
        put(:update, params: { id: booking.id, booking: new_booking })
        expect(flash[:error]).to be_present
      end
    end

    context 'when booking update is successful' do
      it 'assigns the requested booking as booking' do
        expect(assigns(:booking)).to eq(booking)
      end

      it 'returns a status of 302' do
        expect(controller).to respond_with(302)
      end

      it 'redirects back to edit booking page' do
        expect(response).to redirect_to(edit_booking_path)
      end
    end
  end
end
