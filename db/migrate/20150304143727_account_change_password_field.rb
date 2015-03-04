class AccountChangePasswordField < ActiveRecord::Migration
  def change
      add_column :accounts, :password_digest , :string
      remove_column :accounts, :password
  end
end
