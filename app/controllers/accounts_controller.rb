class AccountsController < ApplicationController


  def new
    @account = Account.new
    @account.build_person
  end

  def edit
    @account = Account.find(params[:id])
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

  # def update
  #   if @account.update(account_params)
  #     redirect_to @account, notice: 'Account was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # def destroy
  #   @account.destroy
  #   redirect_to accounts_url, notice: 'Account was successfully destroyed.'
  # end

  private

  def account_params
    params.require(:account).permit(:email, :password, :password_confirmation, person_attributes: [:first_name, :last_name])
  end
end
