class AddStatusToNote < ActiveRecord::Migration
  def change
    add_column :notes, :status, :integer
  end
end
