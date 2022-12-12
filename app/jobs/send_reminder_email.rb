class SendReminderEmail
  def perform
    reminders = Reminder.email.not_completed.until_today
    reminders.each do |reminder|
      email = reminder.customer.email
      if email =~ EMAIL_REGEX
        UserMailer.reminder_email(email).deliver_now
        reminder.update completed: true, error: nil
      else
        reminder.update completed: false, error: 'Email not valid'
      end
    end
  end
end
