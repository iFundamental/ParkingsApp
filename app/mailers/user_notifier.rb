class UserNotifier < ApplicationMailer
  def send_signup_email(account)
    @account=account
     mail(to: account.email, subject: 'Welcome to Bookparking', template_name: 'send_signup_email')
  end
end
