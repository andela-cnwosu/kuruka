require 'rails_helper'

RSpec.describe "UsersLogin", type: :request do

  before(:each) do
    @user = create(:user)
  end

  scenario "GET /users_login" do
    it "works! (now write some real specs)" do
      get users_login_path
      expect(response).to have_http_status(200)
    end
  end

  scenario "when user logs in with invalid information" do
    get root_path
    post login_path, params: { session: { email: "", password: "" } }
    get 'users.json'
    expect(page).to have_content('Out')
  end

  scenario "when login with valid information followed by logout" do
    get login_path
    fill_in "email", :with => @user.email
    fill_in "password", :with => BCrypt::Password.new(@user.password_digest)
    find_button('Login').trigger('click')
    expect(@user).to be_signed_in
    delete logout_path
    expect(@user).not_to be_signed_in
    expect(page).to redirect_to root_url
  end
end
