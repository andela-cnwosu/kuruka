# frozen_string_literal: true
class UsersController < ApplicationController
  before_action :set_user

  def update
    params = user_params.reject! { |_key, value| value.blank? }
    if @user.update params
      flash_message :success, updated_user_message
    else
      flash_model_error_message @user
    end
    redirect_back(fallback_location: root_url)
  end

  def create
    user = User.new user_params
    if user.save
      process_sign_in(user)
    else
      respond_json_error full_error_message(user)
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :id,
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :avatar
    )
  end
end
