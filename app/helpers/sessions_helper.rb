module SessionsHelper
  
  def current_user
    @current_user ||= User.find(cookies.signed[:user_id]) if cookies.signed[:user_id]
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def logged_in?
    !current_user.nil?
  end
  
  def log_in(user)
    cookies.signed[:user_id] = user.id
  end
  
  def ensure_user_logged_in
    redirect_to login_path, flash: { :warning => "Loggin required!" } unless logged_in? 
  end
end