# frozen_string_literal: true
class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    if authenticated_user?(user)
      prepare_for_sign_in user
    else
      invalidate_user
    end
  end

  def invalidate_user
    respond_json_error invalid_login_message
  end

  def authenticated_user?(user)
    user&.authenticate(params[:session][:password])
  end

  def destroy
    log_out if signed_in?
    flash_message :success, log_out_message
    redirect_to root_url
  end
end
