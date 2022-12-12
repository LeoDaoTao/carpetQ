# == Schema Information
#
# Table name: invoices
#
#  id           :integer          not null, primary key
#  service_date :date
#  service_time :time
#  date         :date
#  paid         :boolean          default(FALSE)
#  note         :text
#  total        :money
#  customer_id  :integer
#  event_id     :integer
#  discount_id  :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_invoices_on_customer_id  (customer_id)
#  index_invoices_on_discount_id  (discount_id)
#  index_invoices_on_event_id     (event_id)
#
# Foreign Keys
#
#  fk_rails_0d349e632f  (customer_id => customers.id)
#  fk_rails_aa64c7515d  (event_id => events.id)
#  fk_rails_f24e5b93f7  (discount_id => discounts.id)
#

class InvoicesController < ApplicationController
  def index
    @page_name = 'Invoices'
    @invoices = Invoice.order(id: :desc).page params[:page]
  end

  def new
    @invoice = Invoice.new
    @event = Event.find_by id: params[:event_id]
    @page_name = 'New Invoice'
    @services = Service.order :name
    @invoice_images = InvoiceImage.all
    
    return redirect_to invoices_path, alert: 'Event does not exist' unless @event.present?
    return redirect_to invoices_path, alert: 'Customer does not exist' unless @event.customer.present?
  end

  def create
    @invoice = Invoice.new invoice_params
    @invoice_images = InvoiceImage.all

    if @invoice.save
      @invoice.event.invoice_id = @invoice.id
      @invoice.event.save

      customer_id = @invoice.customer.id
      reminder_date = params[:invoice][:reminder_date]
      reminder_txt = params[:reminder_txt] == '1'
      reminder_email = params[:reminder_email] == '1'
      reminder_phone = params[:reminder_phone] == '1'

      Reminder.add(customer_id: customer_id, date: reminder_date, reminder_method: :txt)   if reminder_txt
      Reminder.add(customer_id: customer_id, date: reminder_date, reminder_method: :email) if reminder_email
      Reminder.add(customer_id: customer_id, date: reminder_date, reminder_method: :phone) if reminder_phone

      redirect_to invoices_path, notice: 'Invoice Created'
    else
      @page_name = 'New Invoice'
      @services = Service.order :name

      render :new
    end
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @page_name = 'Edit Invoice'
    @event = Event.find_by(id: @invoice.event_id)
    @services = Service.order :name
    @invoice_images = InvoiceImage.all
  end

  def update
    @invoice = Invoice.find params[:id]
    @invoice_images = InvoiceImage.all

    if @invoice.update(invoice_params)
      redirect_to invoices_path, notice: 'Invoice Updated'
    else
      @page_name = 'Edit Invoice'
      @event = Event.find_by(id: @invoice.event_id)
      @services = Service.order :name

      render :edit
    end
  end

  def show
    @invoice = Invoice.find(params[:id])
    @page_name = 'Invoice'
    @event = Event.find_by(id: @invoice.event_id)

    respond_to do |format|
      format.html
      format.pdf do
        pdf = InvoicePdf.new @invoice, view_context
        send_data pdf.render, filename: "quickdry_invoice_#{@invoice.id}.pdf",
                              type: 'application/pdf',
                              disposition: 'inline'
      end
    end
  end

  def destroy
    #Add transaction here!!!
    @invoice = Invoice.find(params[:id])
    @invoice.event.invoice_id = nil
    @invoice.event.save
    @invoice.destroy
    redirect_to :back, alert: "Invoice deleted!"
  end

  def email_invoice
    @invoice = Invoice.find(params[:invoice_id])

    InvoiceMailer.invoice_email(@invoice.customer.email, @invoice).deliver

    redirect_to invoices_path, notice: 'Invoice E-mailed'
  end
  
  private

  def invoice_params
    params
      .require(:invoice)
      .permit(:date, :service_time, :total, :customer_id, :discount_id, :event_id, :note,
             invoice_items_attributes: [
               :id, :service_id, :description, :dimensions,
               :unit_cost, :total_cost, :_destroy
             ])
  end
end
