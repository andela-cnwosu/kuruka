# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Route, type: :model do
  before do
    create :airport
  end

  subject :route do
    create :route
  end

  describe 'associations' do
    it 'has many flights' do
      expect(route).to have_many(:flights)
    end

    it 'has many airfares' do
      expect(route).to have_many(:airfares)
    end

    it 'belongs to a departure airport' do
      expect(route).to belong_to(:departure_airport)
    end

    it 'belongs to an arrival airport' do
      expect(route).to belong_to(:arrival_airport)
    end
  end
end
