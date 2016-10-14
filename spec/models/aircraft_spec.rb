# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Aircraft, type: :model do
  subject :aircraft do
    create :aircraft
  end

  describe 'associations' do
    it 'has many flights' do
      expect(aircraft).to have_many(:flights)
    end
  end
end
