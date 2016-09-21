class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:session][:email].downcase)
    (prepare_for_sign_in(user) if authenticated_user?(user)) || invalidate(user)
  end

  def invalidate(user)
    respond_json_error(invalid_field_message(user.nil? ? "email" : "password"))
  end

  def authenticated_user?(user)
    user && user.authenticate(params[:session][:password])
  end

  def destroy
    log_out if signed_in?
    flash_message :success, log_out_message
    redirect_to root_url
  end
end