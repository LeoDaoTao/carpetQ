class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :last_name
      t.string :first_name
      t.string :company_name
      t.string :phone_home
      t.string :phone_work
      t.string :phone_mobile1
      t.string :phone_mobile2
      t.string :email
      t.string :address
      t.string :city
      t.string :state, limit: 2
      t.string :zip
      t.text :note

      t.timestamps null: false
    end
  end
end
