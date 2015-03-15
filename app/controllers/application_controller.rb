class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  helper_method :current_person

  def default_url_options(options = {})
    I18n.locale == :en ? {} : { locale: I18n.locale }
  end

  private

  def current_person
    current_account.person if logged_in?
  end

  def set_locale
    logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"
    I18n.locale = params[:locale] || extract_locale_from_accept_language_header
    logger.debug "* Locale set to '#{I18n.locale}'"
  end

  def current_account
    account = Account.find_by_id(session[:account_id])
    if account.nil?
      account = FacebookAccount.find_by_id(session[:facebook_account_id])
    end
    account
  end

  def logged_in?
    !current_account.nil?
  end
 
  def require_login
    unless logged_in?
      session[:return_to] = request.path
      flash[:alert] = 'You must be logged in to access this section'
      redirect_to login_url
    end
  end

  def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end
end
