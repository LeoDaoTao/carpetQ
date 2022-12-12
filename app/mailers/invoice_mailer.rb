class InvoiceMailer < ApplicationMailer
  default :from => ''

  def invoice_email(email_to, invoice)
    # When sandboxed do not send to real users!!!!!
    email_to = Setting.sandbox_delivery_email if Setting.sandbox == 'true'

    invoice = InvoicePdf.new(invoice, view_context)
    attachments['invoice.pdf'] = { :mime_type => 'application/pdf', :content => invoice.render }
    mail(
      to: email_to,
      from: "#{Setting.name_from} <#{Setting.gmail_user}>",
      subject: "Carpet & Tile Cleaning Receipt"
    )
  end
end
