class Account < ActiveRecord::Base
  belongs_to :person
  accepts_nested_attributes_for :person
  has_secure_password

  def self.authenticate(email, password)
    account = Account.find_by email: email
    if account.nil?
      false
    else
      account.authenticate(password)
    end
  end
end

