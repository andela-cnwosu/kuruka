require 'rails_helper'

RSpec.describe State, type: :model do
  before do
    @state = create :state
  end

  describe "#has_many" do
    it "has many airports" do
      expect(@state).to have_many(:airports)
    end
  end

  describe "#belongs_to" do
    it "belongs to a country" do
      expect(@state).to belong_to(:country)
    end
  end
end
