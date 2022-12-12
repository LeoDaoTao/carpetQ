class UserMailer < ApplicationMailer
  def reminder_email(email_to)
    # When sandboxed do not send to real users!!!!!
    email_to = Setting.sandbox_delivery_email if Setting.sandbox == 'true'

    mail(
      to: email_to,
      from: "#{Setting.name_from} <#{Setting.gmail_user}>",
      subject: Setting.reminder_title
    )
  end
end
