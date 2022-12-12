# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :money
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ServicesController < ApplicationController
  def index
    @services = Service.order(:name)
    @page_name = 'Services'
  end

  def new
    @service = Service.new
    @page_name = 'Add Service'
  end

  def create
    @service = Service.new service_params

    if @service.save
      redirect_to services_path, notice: 'Service Successfully Created'
    else
      @page_name = 'Add Service'
      render :new
    end
  end

  def edit
    @service = Service.find(params[:id])
    @page_name = 'Edit Service'
  end

  def update
    @service = Service.find(params[:id])

    if @service.update(service_params)
      redirect_to services_path, notice: 'Service Successfully Updated'
    else
      @page_name = 'Edit Service'
      render :edit, error: 'Plese correct all erorrs'
    end
  end

  def destroy
    @service = Service.find(params[:id])
    @service.destroy
    redirect_to services_path, notice: 'Service Deleted'
  end

  private

  def service_params
    params.require(:service)
          .permit(:name, :price)
  end
end
