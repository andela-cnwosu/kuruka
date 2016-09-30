# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FlightsController, type: :controller do
  let(:flight_params) do
    {
      departure_date: Faker::Time.between(Date.today, 40.days.from_now, :all),
      routes: {
        departure_airport_id: 2,
        arrival_airport_id: 1
      }
    }
  end

  before do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'POST #search' do
    it 'returns a status of 200' do
      post :search, params: { flight_search: flight_params }
      expect(controller).to respond_with 200
    end
  end

  describe '#reject_empty' do
    it 'responds to reject_empty' do
      expect(controller).to respond_to :reject_empty
    end
  end

  describe '#search_params' do
    it 'does not respond to private method search_params' do
      expect(controller).not_to respond_to :search_params
    end
  end
end
