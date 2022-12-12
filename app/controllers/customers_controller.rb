# == Schema Information
#
# Table name: customers
#
#  id            :integer          not null, primary key
#  last_name     :string
#  first_name    :string
#  company_name  :string
#  phone_home    :string
#  phone_work    :string
#  phone_mobile1 :string
#  phone_mobile2 :string
#  email         :string
#  address       :string
#  city          :string
#  state         :string(2)
#  zip           :string
#  note          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class CustomersController < ApplicationController
  def index
    @page_name = "Customers"

    if params[:search].present?
      @customers = Customer.basic_search(params[:search]).page params[:page]
    else
      @customers = Customer.all.order(:last_name).page params[:page]
    end
  end

  def show
    @customer = Customer.find(params[:id])
    @page_name = "Customer Info"
    @events = @customer.events.order(:date, :time_start)
    @invoices = @customer.invoices.order(date: :desc)
    @reminders = @customer.reminders.order(date: :desc)
  end

  def new
    @customer = Customer.new
    @page_name = "Add New Customer"

    @return_to_event = true if params[:start_time].present?
    @page_name = "Add New Customer & Return to Appointment" if @return_to_event
  end

  def edit
    @page_name = "Edit Customer"
    @customer = Customer.find(params[:id])
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      start_time = params[:start_time]
      end_time = params[:end_time]

      if start_time.present?
        redirect_to new_event_path(start_time: start_time, end_time: end_time, customer_id: @customer.id), notice: "Customer Successfully Created"
      else
        redirect_to customers_path, notice: "Customer Successfully Created"
      end
    else
      render :new
    end
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customers_path, notice: "Customer Successfully Updated"
    else
      render :edit
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer.deletable?
      @customer.destroy
      redirect_to customers_path, alert: 'Customer Deleted'
    else
      redirect_to customers_path, alert: 'Customer Cannot be Deleted!'
    end
  end

  private

  def customer_params
    params
      .require(:customer)
      .permit(:first_name, :last_name, :company_name, 
              :email, :address, :city, :state, :zip, :note,
              phones_attributes: [:id, :number, :label, :textable, :_destroy],
              addresses_attributes: [:id, :label, :address, :city, :state, :zip, :_destroy]
             )
  end
end
