class CreateInvoiceImages < ActiveRecord::Migration
  def change
    create_table :invoice_images do |t|
      t.string :name
      t.attachment :image

      t.timestamps null: false
    end
  end
end
