class RenameDimentionsColumn < ActiveRecord::Migration
  def change
    rename_column :invoice_items, :dimentions, :dimensions
  end
end
