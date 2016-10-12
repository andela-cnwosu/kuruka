# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before :all do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'GET #index' do
    context 'when a user is registered' do
      before do
        session[:user_id] = 1
      end

      it 'returns a status of 200' do
        get :index
        expect(controller).to respond_with(:ok)
      end

      it 'returns all the bookings made by the user' do
        booking = create(:booking, user: User.first)
        get :index
        expect(response.body).to include(booking.booking_ref)
      end

      it 'renders the index template' do
        get :index
        expect(response).to render_template(:index)
      end

      it 'shows the pagination div on page' do
        bookings = []
        user = User.first
        params = { user: user, passenger_email: Faker::Internet.email }
        20.times do |_number|
          bookings << create(:booking, params)
        end
        get :index
        expect(response.body).to have_selector('div.pagination')
      end
    end

    context 'when a user is anonymous' do
      it 'redirects to the home page' do
        get :index
        expect(response).to redirect_to(root_path)
      end
    end
  end
end
