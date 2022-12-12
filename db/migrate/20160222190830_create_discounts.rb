class CreateDiscounts < ActiveRecord::Migration
  def change
    create_table :discounts do |t|
      t.string :name, limit: 20
      t.decimal :value

      t.timestamps null: false
    end
  end
end
