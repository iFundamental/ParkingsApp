class SessionsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    account = Account.authenticate(session_params[:email], session_params[:password])
    if account != false
      session[:account_id] =  account.id
      redirect_to parkings_url
    else
      log_in_failed
    end
  end

  def destroy
    session[:account_id] = ''
    redirect_to new_session_url, notice: 'You have successfully logged out.'
  end

  private

  def log_in_failed
    redirect_to new_session_url, notice: 'Login failed. Incorrect username or password.'
  end

  def session_params
    params.require(:account).permit(:email, :password)
  end
end
