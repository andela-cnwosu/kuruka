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

  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'POST #search' do
    context "when a flight is found from the search params" do
      before do
        post(:search, params: { flight_search: flight_params })
      end

      it 'returns a status of 200' do
        expect(controller).to respond_with(200)
      end

      it 'renders a search results partial' do
        expect(response).to render_template(partial: 'flights/_search_results')
      end

      it 'assigns flights to the view' do
        expect(assigns(:flights)).not_to be_nil
      end
    end

    context "when a flight is not found from the search params" do
      it 'assigns nil value of flights to the page' do
        flight_params[:arrival_airport_id] = 0
        post(:search, params: { flight_search: flight_params })
        expect(assigns(:flights)).to be_empty
      end
    end
  end

  describe '#reject_empty' do
    it 'responds to reject_empty' do
      expect(controller).to respond_to(:reject_empty)
    end
  end

  describe '#search_params' do
    it 'does not respond to private method search_params' do
      expect(controller).not_to respond_to(:search_params)
    end
  end
end
