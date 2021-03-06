# frozen_string_literal: true
require 'rails_helper'

RSpec.describe User, type: :model do
  subject :user do
    create(:user, email: 'new_user@gmail.com')
  end

  describe 'associations' do
    it 'has many bookings' do
      expect(user).to have_many(:bookings)
    end

    it 'has one passenger' do
      expect(user).to have_one(:passenger)
    end

    it 'accepts nested attributes for passenger' do
      expect(user).to accept_nested_attributes_for(:passenger)
    end

    it 'has secure password' do
      expect(user).to have_secure_password
    end
  end

  describe 'validations' do
    it 'validates length of password' do
      expect(user).to validate_length_of(:password)
    end

    it 'validates presence of first name' do
      expect(user).to validate_presence_of(:first_name)
    end

    it 'validates presence of last name' do
      expect(user).to validate_presence_of(:last_name)
    end

    it 'validates presence of email' do
      expect(user).to validate_presence_of(:email)
    end

    it 'validates uniqueness of email' do
      expect(user).to validate_uniqueness_of(:email)
    end
  end

  describe '#full_name' do
    it 'returns the first and last name string of the user' do
      expect(user.full_name).to eql('Chineze Nwosu')
    end
  end

  describe '#remember' do
    it 'updates the remember digest' do
      initial_remember = user.remember_digest
      user.remember
      expect(user.remember_digest).not_to eql(initial_remember)
    end
  end

  describe '#forget' do
    it 'resets the initial remember digest to nil' do
      user.forget
      expect(user.remember_digest).to eql(nil)
    end
  end

  describe '#authenticated?' do
    context 'when user has valid remember digest' do
      it 'returns true' do
        user.remember
        expect(user.authenticated?(user.remember_token)).to eql(true)
      end
    end

    context 'when user has no remember digest' do
      it 'returns true' do
        user.remember
        user.update_attributes(remember_digest: nil)
        expect(user.authenticated?(user.remember_token)).to eql(false)
      end
    end

    context 'when user has invalid remember digest' do
      it 'returns true' do
        user.remember
        user.update_attributes(remember_digest: '1234asdf')
        expect(user.authenticated?(user.remember_token)).to eql(false)
      end
    end
  end

  describe '#instance_methods' do
    it 'responds to password confirmation' do
      expect(user).to respond_to(:password_confirmation)
    end

    it 'responds to authenticate' do
      expect(user).to respond_to(:authenticate)
    end
  end

  describe '#before_save' do
    before do
      user.email = 'USER@YAhoo.com'
      user.save
    end

    it 'has a generated remember digest' do
      expect(user.remember_digest).not_to be_blank
    end

    it 'has an email that is downcased' do
      expect(user.email).to eql('user@yahoo.com')
    end
  end

  describe 'has_attached_file' do
    it 'has an attached avatar' do
      expect(user).to have_attached_file(:avatar)
    end

    it 'validates the avatar content type' do
      expect(user).to validate_attachment_content_type(:avatar)
        .allowing('image/png', 'image/gif')
        .rejecting('text/plain', 'text/xml')
    end
  end
end
