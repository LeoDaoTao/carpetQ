class AddInvoiceReferenceToEvent < ActiveRecord::Migration
  def change
    add_reference :events, :invoice, index: true, foreign_key: true
  end
end
