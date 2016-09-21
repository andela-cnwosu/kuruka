require 'rails_helper'

RSpec.describe User, type: :model do
  before(:each) do
    @user = create(:user)
  end

  scenario "when user is instantiated" do
    expect(@user).to respond_to(:password_confirmation)
    expect(@user).to respond_to(:remember_token)
    expect(@user).to respond_to(:authenticate)
  end

  describe "Remember Token" do
    before do
      @user.save
    end

    scenario "when user is saved with remember me" do
      expect(@user.remember_token).not_to be_blank
    end

    # scenario "when a remember token is generated" do
    #   expect(@user.generate_remember_token).to be_blank
    # end
  end
end
