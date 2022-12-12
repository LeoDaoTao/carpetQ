class SendReminderTxt
  def perform
    reminders = Reminder.txt.not_completed.until_today
    reminders.each do |reminder|
      reminder_phones = reminder.customer.phones_textable
      next if reminder_phones.empty?
      reminder_phones.each do |phone|
        phone.number.prepend('+1')
        ReminderTxt.send!(phone.number)
        reminder.update completed: true, error: nil
      end
    end
  end
end
