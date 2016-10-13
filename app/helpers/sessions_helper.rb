# frozen_string_literal: true
module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def signed_in?
    !current_user.nil?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def process_sign_in(user)
    sign_in user
    flash_message(:success, log_in_message)
    redirect_to root_url
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def require_login
    return if signed_in?
    flash_message(:error, require_login_message)
    redirect_to root_url
  end

  def set_user
    @user = current_user || User.new
  end

  def set_passenger_count
    passenger_count = params[:passenger_count]
    session[:passenger_count] = (1 if passenger_count.blank?) || passenger_count
  end

  def clear_passenger_count
    session.delete(:passenger_count)
  end

  def current_user_id
    (current_user.id if current_user) || nil
  end

  def respond_json_error(message)
    render(json: { success: false, errors: message })
  end
end
