class Account < ActiveRecord::Base
  belongs_to :person
  accepts_nested_attributes_for :person
  has_secure_password

  def self.authenticate(email, password)
    account = Account.find_by email: email
    account.authenticate(password) if account
  end
end

