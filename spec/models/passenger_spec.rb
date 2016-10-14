# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Passenger, type: :model do
  before do
    create :airport
    create :route
    create :flight
  end

  subject :passenger do
    create(:passenger, user: nil)
  end

  describe 'associations' do
    it 'belongs to a user' do
      expect(passenger).to belong_to(:user)
    end

    it 'belongs to a booking' do
      expect(passenger).to belong_to(:booking)
    end

    it 'belongs to an airfare' do
      expect(passenger).to belong_to(:airfare)
    end
  end

  describe 'validations' do
    it 'validates length of phone number' do
      expect(passenger).to validate_length_of(:phone)
    end

    it 'validates presence of first name' do
      expect(passenger).to validate_presence_of(:first_name)
    end

    it 'validates presence of last name' do
      expect(passenger).to validate_presence_of(:last_name)
    end

    it 'validates presence of airfare' do
      expect(passenger).to validate_presence_of(:airfare)
    end
  end

  describe '#full_name' do
    it 'returns the first and last name string of the passenger' do
      expect(passenger.full_name).to eql('Chineze Nwosu')
    end
  end

  describe '#fare' do
    it 'returns the total cost for a passenger' do
      expect(passenger.fare).to eql(1100.0)
    end
  end
end
