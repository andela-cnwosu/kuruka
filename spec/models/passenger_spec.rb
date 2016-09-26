require 'rails_helper'

RSpec.describe Passenger, type: :model do
  before do
    create(:airport)
    create(:route)
    create(:flight)
    @passenger = create :passenger, user: nil
  end

  describe "#belongs_to" do
    it "belongs to a user" do
      expect(@passenger).to belong_to(:user)
    end
  end

  describe "#belongs_to" do
    it "belongs to a booking" do
      expect(@passenger).to belong_to(:booking)
    end
  end

  describe "#belongs_to" do
    it "belongs to an airfare" do
      expect(@passenger).to belong_to(:airfare)
    end
  end

  describe "#validates_length_of" do
    it "validates length of phone number" do
      expect(@passenger).to validate_length_of(:phone)
    end
  end
end
