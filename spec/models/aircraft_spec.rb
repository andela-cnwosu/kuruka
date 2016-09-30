# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Aircraft, type: :model do
  describe '#has_many' do
    it { is_expected.to have_many(:flights) }
  end
end
