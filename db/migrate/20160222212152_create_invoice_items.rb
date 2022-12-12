class CreateInvoiceItems < ActiveRecord::Migration
  def change
    create_table :invoice_items do |t|
      t.string :description
      t.string :dimentions
      t.money :unit_cost
      t.money :total_cost
      t.references :service, index: true, foreign_key: true
      t.references :invoice, index: true, foreign_key: { on_delete: :cascade }

      t.timestamps null: false
    end
  end
end
