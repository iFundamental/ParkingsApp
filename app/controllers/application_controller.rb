class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_person
  
  private

  def current_person
    if current_account.nil?
      nil
    else
      @account.person
    end
  end

  def current_account
    @account = Account.find_by_id(session[:account_id])

  end
end
