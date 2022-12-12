class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :label, limit: 50
      t.string :address
      t.string :city, limit: 30
      t.string :state, limit: 2, default: 'CA'
      t.string :zip, limit: 10
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
