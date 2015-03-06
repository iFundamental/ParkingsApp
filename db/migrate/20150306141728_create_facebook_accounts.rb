class CreateFacebookAccounts < ActiveRecord::Migration
  def change
    create_table :facebook_accounts do |t|
      t.references :person, index: true
      t.string :uid
      t.timestamps null: false
    end
    add_foreign_key :accounts, :people
  end
end

