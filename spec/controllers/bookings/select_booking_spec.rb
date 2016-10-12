# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before :all do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'POST #select' do
    context 'when a flight is selected' do
      it 'redirects to the new bookings page' do
        post :select
        expect(response).to redirect_to(new_booking_path)
      end
    end
  end
end
