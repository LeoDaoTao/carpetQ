class RenameMethodToReminderMethodForReminders < ActiveRecord::Migration
  def change
    rename_column :reminders, :method, :reminder_method
    add_index     :reminders, :reminder_method
  end
end
