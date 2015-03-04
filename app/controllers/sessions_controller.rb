class SessionsController < ApplicationController

  def new
    @account = Account.new
  end

  def create
    @account = Account.find_by email: session_params[:email]
    if @account.nil?
      log_in_failed
    elsif @account.password == session_params[:password]
      session[:account_id] =  @account.id
      redirect_to parkings_url
    else
      log_in_failed
    end
  end

  def destroy
    session[:account_id] = ''
    redirect_to root_url
  end

  private

  def log_in_failed
    redirect_to new_session_url, notice: 'Login failed. Incorrect username or password.'
  end

  def session_params
    params.require(:account).permit(:email, :password)
  end
end
