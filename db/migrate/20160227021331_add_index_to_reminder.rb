class AddIndexToReminder < ActiveRecord::Migration
  def change
    add_index :reminders, :completed
  end
end
