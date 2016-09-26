module Features
  module UserHelpers
    def sign_in
      password = "password"
      user = FactoryGirl.create(:user, password: password)
      sign_in_with user.email, password
    end

    def sign_in_with(email, password)
      visit root_path
      find_link('Sign In').click
      fill_in "session[email]", with: email
      fill_in "session[password]", with: password
      find_button("Log In").click
    end

    def sign_out
      find_link('Log Out', match: :first).click
    end

    def sign_up_with(first_name, last_name, email, password, password_confirm)
      visit root_path
      find_link('Sign In').click
      within '.modal-content' do
        find_link('create an account').click
        fill_in "user[first_name]", with: first_name
        fill_in "user[last_name]", with: last_name
        fill_in "user[email]", with: email
        fill_in "user[password]", with: password
        fill_in "user[password_confirmation]", with: password_confirm
        find_button("Create Account").click
      end
    end

    def expect_user_to_be_signed_in
      visit root_path
      expect(page).not_to have_link "Sign In"
    end

    def expect_user_to_be_signed_out
      expect(page).to have_link "Sign In"
    end

    def expect_invalid_login_error
      expect(page).to have_content "Your login information is incorrect"
    end

    def expect_blank_param_error(param)
      expect(page).to have_content "#{param} must not be blank"
    end
  end
end

RSpec.configure do |config|
  config.include Features::UserHelpers, type: :feature
end
