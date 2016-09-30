# frozen_string_literal: true
require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  let(:signed_in_user) do
    {
      email: 'signedinuser@gmail.com',
      password: 'password'
    }
  end

  describe 'POST #create' do
    before do
      @user = create(:user, email: 'signedinuser@gmail.com')
      post(:create, params: { session: signed_in_user })
    end

    context 'when email and password are valid' do
      it 'responds with 200' do
        expect(controller).to respond_with(:ok)
      end
    end

    context 'when email is invalid' do
      it 'returns a json response' do
        signed_in_user[:email] = 'wrong_user@gmail.com'
        post(:create, params: { session: signed_in_user })
        expect(response.body).to include('Your login information is incorrect')
      end
    end

    context 'when password is invalid' do
      it 'returns a json response' do
        signed_in_user[:password] = 'wrongpassword'
        post(:create, params: { session: signed_in_user })
        expect(response.body).to include('Your login information is incorrect')
      end
    end
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
