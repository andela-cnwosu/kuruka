# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  let(:new_booking) do
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

  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'GET #new' do
    before do
      flight = Flight.first
      get(:new, params: { flight: flight })
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end

    it 'returns a status of 200' do
      expect(controller).to respond_with(:ok)
    end
  end

  describe 'POST #create' do
    context 'when booking creation is successful' do
      it 'returns a status of 302' do
        post(:create, params: { booking: new_booking })
        expect(controller).to respond_with(302)
      end
    end

    context 'when booking creation fails' do
      before do
        new_booking[:passenger_email] = 'wrong_email'
        post(:create, params: { booking: new_booking })
      end

      it 'returns a flash error message' do
        expect(flash[:error]).to be_present
      end

      it 'returns a status of 302' do
        expect(controller).to respond_with(302)
      end
    end
  end
end
