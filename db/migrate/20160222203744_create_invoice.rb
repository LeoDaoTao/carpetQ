class CreateInvoice < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.date :service_date
      t.time :service_time
      t.date :date
      t.boolean :paid, default: false
      t.text :note
      t.money :total
      t.references :customer, index: true, foreign_key: true
      t.references :event, index: true, foreign_key: true
      t.references :discount, index: true, foreign_key: true, default: nil

      t.timestamps null: false
    end
  end
end
