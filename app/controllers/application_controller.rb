class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person
  
  private

  def current_person
    account = current_account
    if account.nil?
      nil
    else
      account.person
    end
  end

  def current_account
    Account.find_by_id(session[:account_id])
  end

  def logged_in?
    !current_account.nil?
  end
 
  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to access this section'
      redirect_to new_session_url
    end
  end
end
