require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:new_user) do
    {
      first_name: "Chinese",
      last_name: "Benny",
      email: "newuser@gmail.com",
      password: "password",
      password_confirmation: "password"
    }
  end

  describe "POST #create" do
    it "redirects to signed in page" do
      post :create, params: { user: new_user }
      expect(controller).to respond_with 302
    end
  end

  describe "PUT #update" do
    before do
      @existing_user = create :user
      new_user[:last_name] = "Ben"
      put :update, params: { id: @existing_user.id, user: new_user }
    end

    it "returns a status of 302" do
      expect(controller).to respond_with 302
    end

    it "redirects back to root path" do
      expect(response).to redirect_to(root_path)
    end
  end
end