# frozen_string_literal: true
require 'rails_helper'

RSpec.describe State, type: :model do
  subject :state do
    create :state
  end

  describe 'associations' do
    it 'has many airports' do
      expect(state).to have_many(:airports)
    end

    it 'belongs to a country' do
      expect(state).to belong_to(:country)
    end
  end
end
