# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Flight, type: :model do
  before do
    create :airport
    create :route
    Flight.destroy_all
  end

  subject :flight do
    create :flight
  end

  describe '#has_many' do
    it 'has many bookings' do
      expect(flight).to have_many(:bookings)
    end
  end

  describe '#belongs_to' do
    it 'belongs to a aircraft' do
      expect(flight).to belong_to(:aircraft)
    end
  end

  describe '#belongs_to' do
    it 'belongs to a route' do
      expect(flight).to belong_to(:route)
    end
  end
end
