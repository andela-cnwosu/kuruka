module SessionsHelper
  def sign_in(user)
    session['user_id'] = user.id
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
      user = User.find_by id: user_id
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  def prepare_for_sign_in(user)
    process_sign_in user
    set_remember_me user
  end

  def process_sign_in(user)
    sign_in user
    flash_message :success, log_in_message
    redirect_to root_url
  end

  def set_remember_me(user)
    params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  end

  def log_out
    forget current_user
    session.delete :user_id
    @current_user = nil
  end

  def require_login
    unless signed_in?
      flash_message :error, require_login_message
      redirect_to root_url
    end
  end

  def set_user
    @user = current_user || User.new
  end

  def set_passenger_count
    passenger_count = params[:passenger_count]
    session[:passenger_count] = passenger_count.blank? ? 1 : passenger_count
  end

  def clear_passenger_count
    session.delete :passenger_count
  end

  def current_user_id
    (current_user.id if current_user) || nil
  end
end