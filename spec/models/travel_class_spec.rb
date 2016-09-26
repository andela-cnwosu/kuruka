require 'rails_helper'

RSpec.describe TravelClass, type: :model do
  before do
    @travel_class = create(:travel_class)
  end

  describe "#has_many" do
    it "has many airfares" do
      expect(@travel_class).to have_many(:airfares)
    end
  end
end
