class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.references :person, index: true
      t.string :email
      t.string :password
      t.timestamps null: false
    end
    add_foreign_key :accounts, :people
    add_index :accounts, :email, unique: :true
  end
end
