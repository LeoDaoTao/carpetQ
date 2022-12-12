class ReminderTxt
  def self.send!(phone)
    # Set Sandbox. Very Important!!!
    phone = Setting.sandbox_delivery_phone if Setting.sandbox == 'true'

    @twilio = Twilio::REST::Client.new Setting.sms_account_sid, Setting.sms_auth_token
     
    @twilio.account.messages.create({
      from:  Setting.sms_number,
      to:    phone,
      body:  Setting.reminder_sms
    })
  end
end
