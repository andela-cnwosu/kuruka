# frozen_string_literal: true
module Features
  module UserHelpers
    def sign_in
      password = 'password'
      user = FactoryGirl.create(:user, password: password)
      sign_in_with(user.email, password)
      user
    end

    def sign_in_with(email, password)
      visit root_path
      find_link('Sign In / Sign Up').click
      within '.modal-content' do
        fill_in('session[email]', with: email)
        fill_in('session[password]', with: password)
        find_button('Log In').click
      end
    end

    def sign_out
      find_link('Log Out', match: :first).click
    end

    def sign_up_with(first_name, last_name, email, password, password_confirm)
      visit root_path
      find_link('Sign In / Sign Up').click
      within '.modal-content' do
        find_link('create an account').click
        fill_in('user[first_name]', with: first_name)
        fill_in('user[last_name]', with: last_name)
        fill_in('user[email]', with: email)
        fill_in('user[password]', with: password)
        fill_in('user[password_confirmation]', with: password_confirm)
        find_button('Create Account').click
      end
    end

    def expect_user_to_be_signed_in
      expect(page).not_to have_link('Sign In / Sign Up')
    end

    def expect_user_to_be_signed_out
      expect(page).to have_link('Sign In / Sign Up')
    end

    def expect_invalid_login_error
      expect(page).to have_content(invalid_login_message)
    end
  end
end
