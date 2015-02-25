class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.integer :owner_id
      t.string :model
      t.string :registration_number

      t.timestamps null: false
    end
  end
end
