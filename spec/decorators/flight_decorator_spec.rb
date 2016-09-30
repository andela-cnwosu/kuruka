# frozen_string_literal: true
require 'rails_helper'

RSpec.describe FlightDecorator, type: :decorator do
  before do
    create :airport
    create :route
    @flight = create(:flight).decorate
    @departed_flight = create(:departed).decorate
  end

  describe '#pastize' do
    it 'responds to pastize' do
      expect(@flight).to respond_to(:pastize)
    end

    context 'when flight has departed' do
      it 'returns the past tense of a word if flight has departed' do
        expect(@departed_flight.pastize('waste')).to eql('wasted')
      end
    end

    context 'when flight has not departed' do
      it 'returns the past tense of a word if flight has departed' do
        expect(@flight.pastize('waste')).to eql('wastes')
      end
    end
  end
end
