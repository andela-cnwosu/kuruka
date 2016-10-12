# frozen_string_literal: true
module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
  end

  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
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
    elsif (user_id = cookies.signed[:user_id])
      log_in_with_remember_token user_id
    end
  end

  def log_in_with_remember_token(user_id)
    user = User.find_by(id: user_id)
    return unless user && user.authenticated?(cookies[:remember_token])
    sign_in user
    @current_user = user
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def prepare_for_sign_in(user)
    remember_user user
    process_sign_in user
  end

  def process_sign_in(user)
    sign_in user
    flash_message(:success, log_in_message)
    redirect_to root_url
  end

  def remember_user(user)
    (remember(user) if params[:session][:remember_me] == '1') || forget(user)
  end

  def log_out
    forget current_user
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
