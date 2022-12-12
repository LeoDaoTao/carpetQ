class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :number, limit: 20, null: false
      t.string :label, limit: 20, null: false
      t.boolean :textable, default: false
      t.references :customer, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
