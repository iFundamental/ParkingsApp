class SessionsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    account = Account.authenticate(session_params[:email], session_params[:password])
    if account != false
      session[:account_id] =  account.id
      if  session[:return_to] == login_url || session[:return_to] .nil?
        redirect_to root_url
      else
        redirect_to session[:return_to]
      end
    else
      log_in_failed
    end
  end

  def failure

  end

  def destroy
    session[:account_id] = ''
    redirect_to login_url, notice: 'You have successfully logged out.'
  end

  private

  def log_in_failed
    redirect_to login_url, notice: 'Login failed. Incorrect username or password.'
  end

  def session_params
    params.require(:account).permit(:email, :password)
  end
end
