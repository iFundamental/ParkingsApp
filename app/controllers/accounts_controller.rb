class AccountsController < ApplicationController
  before_action :find_account, only: [:edit]

  def new
    @account = Account.new
    @account.build_person
  end

  def edit
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      UserNotifier.send_signup_email(@account).deliver_now
      redirect_to login_url, notice: 'Account was successfully created. Please Login.'
    else
      render :new
    end
  end

  private

  def find_account
    @account = Account.find(params[:id])
  end

  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation, person_attributes: [:first_name, :last_name])
  end
end
