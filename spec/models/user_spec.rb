require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create :user, email: "new_user@gmail.com"
  end

  describe "#has_many" do
    it "has many bookings" do
      expect(@user).to have_many(:bookings)
    end
  end

  describe "#has_one" do
    it "has one passenger" do
      expect(@user).to have_one(:passenger)
    end
  end

  scenario "when user is instantiated" do
    expect(@user).to respond_to(:password_confirmation)
    expect(@user).to respond_to(:remember_digest)
    expect(@user).to respond_to(:authenticate)
  end

  describe "Remember Token" do
    before do
      @user.save
    end

    scenario "when user is saved with remember me" do
      expect(@user.remember_digest).not_to be_blank
    end
  end
end
