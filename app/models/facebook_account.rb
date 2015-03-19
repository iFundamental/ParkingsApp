class FacebookAccount < ActiveRecord::Base
  belongs_to :person
  validates :uid, :person, presence: true
  accepts_nested_attributes_for :person

  def self.find_or_create_for_facebook(auth_hash)
    facebook_account = find_by_uid(auth_hash['uid'])
    if facebook_account.nil?
      account = Account.find_by_email(auth_hash['info']['email'])
      if account
        person = account.person
      else
        person = Person.create(first_name: auth_hash['info']['first_name'], last_name: auth_hash['info']['last_name'])
      end
      facebook_account = FacebookAccount.create(person: person, uid: auth_hash['uid'])
    end
    facebook_account
  end
end


