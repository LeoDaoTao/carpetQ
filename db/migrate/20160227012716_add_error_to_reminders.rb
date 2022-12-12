class AddErrorToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :error, :text
  end
end
