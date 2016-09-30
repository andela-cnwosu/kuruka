# frozen_string_literal: true
require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  before do
    create :airport
    create :route
  end

  describe 'ROOT #root' do
    context 'when a user is registered' do
      it 'redirects to user home' do
        create :user
        session[:user_id] = 1
        get :root
        expect(response).to redirect_to(user_home_path)
      end
    end

    context 'when a user is anonymous' do
      it 'redirects to index home' do
        get :root
        expect(response).to redirect_to(home_path)
      end
    end
  end

  describe 'GET #schedule' do
    it 'returns a status of 200' do
      get :schedule
      expect(controller).to respond_with(:ok)
    end

    it 'assigns all flights to the schedule page' do
      @flight = create(:flight)
      get :schedule
      expect(assigns(:flights)).to include(@flight)
    end
  end
end
