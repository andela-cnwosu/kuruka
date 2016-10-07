# frozen_string_literal: true
require 'rails_helper'

RSpec.describe BookingsController, type: :controller do
  before(:all) do
    load "#{Rails.root}/spec/support/seed.rb"
    Seed.create_models
  end

  describe 'GET #manage' do
    it 'returns a status of 200' do
      get :manage
      expect(controller).to respond_with(:ok)
    end

    it 'renders the manage bookings page' do
      get :manage
      expect(controller).to render_template(:manage)
    end
  end
end
