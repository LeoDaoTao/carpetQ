class AddReminderMethodToReminders < ActiveRecord::Migration
  def change
    add_column :reminders, :method, :reminder_method, index: true
  end
end
