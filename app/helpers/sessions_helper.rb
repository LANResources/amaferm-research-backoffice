module SessionsHelper
  def sign_in(user)
    session[:user_id] = user.id
    self.current_user = user
  end

  def sign_out
    session[:user_id] = nil
    session[:impersonating_role] = nil
    self.current_user = GuestUser.new
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= session[:user_id] ? User.find(session[:user_id]) : GuestUser.new
    @current_user.current_role = session[:impersonating_role] if session[:impersonating_role]
    @current_user
  end

  def signed_in?
    !(current_user.nil? || current_user.guest?)
  end

  def deny_access
    store_location
    if signed_in?
      redirect_to root_url, notice: 'You are not authorized to view that page.'
    else
      redirect_to login_path, notice: 'Please sign in to access this page.'
    end
  end

  def current_user?(user)
    user == current_user
  end

  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

  def referred_from_amaferm!
    session[:referred_from_amaferm] = true
  end

  def referred_from_amaferm?
    session[:referred_from_amaferm].present?
  end

  private

  def store_location
    session[:return_to] = request.fullpath
  end

  def clear_return_to
    session[:return_to] = nil
  end
end
