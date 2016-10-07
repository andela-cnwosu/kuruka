# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:signed_in_user) do
    {
      email: 'signedinuser@gmail.com',
      password: 'password'
    }
  end

  describe 'POST #destroy' do
    before do
      post(:create, params: { session: signed_in_user })
      post :destroy
    end

    it 'redirects to root path' do
      expect(controller).to redirect_to(root_path)
    end

    it 'responds with a flash message' do
      expect(flash[:success]).to be_present
    end
  end
end
