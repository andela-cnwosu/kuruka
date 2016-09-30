# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ContactsController, type: :controller do
  let(:contact_param) do
    {
      name: 'Chineze',
      email: 'user@gmail.com',
      message: 'Hi, I am happy'
    }
  end

  describe '#send_mail' do
    it 'sends a mail to Kuruka' do
      expect { post :send_mail, params: { contact: contact_param } }.to change {
        ActionMailer::Base.deliveries.count
      }.by(1)
    end

    it 'returns a json response' do
      post :send_mail, params: { contact: contact_param }
      expect(response.content_type).to eq('application/json')
    end
  end
end
