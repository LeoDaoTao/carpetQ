# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  time_start  :time
#  time_end    :time
#  note        :text
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color       :string
#  description :string(100)
#  city        :string(30)
#  invoice_id  :integer
#
# Indexes
#
#  index_events_on_customer_id  (customer_id)
#  index_events_on_invoice_id   (invoice_id)
#
# Foreign Keys
#
#  fk_rails_37dc3a4c49  (customer_id => customers.id)
#  fk_rails_ca0b457a24  (invoice_id => invoices.id)
#

class EventsController < ApplicationController
  def index
    @page_name = "Calendar"
    @events = Event.all
    events = []

    @events.each do |event|
      events << event.serialize
    end

    gon.date = Date.today
    gon.events = events
  end

  def new
    @event= Event.new
    @customers = Customer.all.order(:last_name).order(:company_name)
    @page_name = "Add New Appointment"
    @start_time = if params[:start_time].present?
                    params[:start_time]
                  else
                    "#{Date.today.stamp('2010-01-15')}T08:00:00"
                  end

    @end_time = if params[:end_time].present?
                  params[:end_time]
                elsif params[:start_time].present?
                  end_time = Chronic.parse params[:start_time]
                  end_time = end_time + 2.hours
                  end_time = end_time.stamp('20:00')
                else
                  '10:00'
                end

    customer = Customer.find_by(id: params[:customer_id])
    @customer_title = customer.title unless customer.nil?
    customers_to_gon
  end

  def create
    @event = Event.new event_params

    if Customer.find_by(id: params[:customer_id])
      customer = Customer.find(params[:customer_id])
      @event.customer = customer
    end

    if @event.save
      redirect_to events_path, notice: "Appointment Created"
    else
      @page_name = "Add New Appointment"
      @event= Event.new event_params

      customers_to_gon
      render action: :new
    end
  end

  def edit
    @page_name = "Edit Appointment"
    @event= Event.find(params[:id])
    @customer_title = @event.customer.title unless @event.customer.nil?
    customers_to_gon
  end

  def update
    @event= Event.find(params[:id])

    if Customer.find_by(id: params[:customer_id])
      @event.customer = Customer.find(params[:customer_id])
    end

    if @event.update(event_params)
      redirect_to events_path, notice: "Appointment Successfully Updated"
    else
      customers_to_gon
      render :new
    end
  end

  def destroy
    # ToDo: Add disable delete for invoiced 
    @event = Event.find(params[:id])
    @event.delete
    redirect_to events_path, notice: 'Event Deleted'
  end

  private

  def event_params
    params
      .require(:event)
      .permit(:customer_id, :description, :city, :date, :time_start, :time_end, :color, :note)
  end

  def customers_to_gon
    customers = Customer.all
    @customers  = []
    customers.each do |customer|
      @customers << {
        title: customer.title,
        id: customer.id
      }
    end

    gon.customers = @customers
  end
end
