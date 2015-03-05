class UserNotifier < ApplicationMailer

  def send_signup_email(account)
    @account=account
     mail(to: account.email, subject: 'Welcome to Bookparking') do |format|
      format.html
      format.text
    end
  end
end
