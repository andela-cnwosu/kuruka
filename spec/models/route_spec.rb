# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Route, type: :model do
  before do
    create :airport
  end

  subject :route do
    create :route
  end

  describe '#has_many' do
    it 'has many flights' do
      expect(route).to have_many(:flights)
    end
  end

  describe '#has_many' do
    it 'has many airfares' do
      expect(route).to have_many(:airfares)
    end
  end

  describe '#belongs_to' do
    it 'belongs to a departure airport' do
      expect(route).to belong_to(:departure_airport)
    end
  end

  describe '#belongs_to' do
    it 'belongs to an arrival airport' do
      expect(route).to belong_to(:arrival_airport)
    end
  end
end
