# frozen_string_literal: true
require 'rails_helper'

RSpec.describe KurukaMailer, type: :mailer do
  describe KurukaMailer do
    before :all do
      create :airport
      create :route
      create :flight
    end

    let :booking do
      create(:booking, user: create(:user, email: 'usr@gmail.com'))
    end

    let :contact_params do
      {
        name: 'Chineze',
        email: 'user@gmail.com',
        message: 'Hi, I am happy'
      }
    end

    describe '#booking_email' do
      it 'sends a mail to the user after booking has been made' do
        booking_mail = KurukaMailer.booking_email(booking)
        expect { booking_mail.deliver }.to change {
          ActionMailer::Base.deliveries.count
        }.by(1)
      end
    end

    describe '#booking_updated_email' do
      it 'sends a mail to the user after booking has been updated' do
        booking_updated_mail = KurukaMailer.booking_updated_email(booking)
        expect { booking_updated_mail.deliver }.to change {
          ActionMailer::Base.deliveries.count
        }.by(1)
      end
    end

    describe '#contact_email' do
      it 'sends a contact message to Kuruka' do
        contact = Contact.new(contact_params)
        contact_mail = KurukaMailer.contact_email(contact)
        expect { contact_mail.deliver }.to change {
          ActionMailer::Base.deliveries.count
        }.by(1)
      end
    end
  end
end
