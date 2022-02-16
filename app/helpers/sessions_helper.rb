module SessionsHelper
  def log_in(user)
    session[:email] = user.email
  end

  def current_user
    return unless session[:email]

    @current_user ||= User.find_by(email: session[:email])
  end

  def log_out
    session.delete(:email)

    @current_user = nil
  end
end
