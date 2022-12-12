# == Schema Information
#
# Table name: invoice_images
#
#  id                 :integer          not null, primary key
#  name               :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class InvoiceImagesController < ApplicationController
  def index
    @page_name = 'Invoice Images'
    @invoice_images = InvoiceImage.order :name
  end

  def new
    @page_name = 'Add Invoice Image'
    @invoice_image = InvoiceImage.new
  end

  def create
    @page_name = 'Add Invoice Image'
    @invoice_image = InvoiceImage.new invoice_image_params

    if @invoice_image.save
      redirect_to invoice_images_path, notice: 'Invoice Image Created'
    else
      render :new
    end
  end

  def edit
    @page_name = 'Edit Invoice Image'
    @invoice_image = InvoiceImage.find params[:id]
  end

  def update
    @page_name = 'Edit Invoice Image'
    @invoice_image = InvoiceImage.find params[:id]

    if @invoice_image.update(invoice_image_params)
      redirect_to invoice_images_path, notice: 'Invoice Image Updated'
    else
      render :edit
    end
  end

  def destroy
    @invoice_image = InvoiceImage.find params[:id]
    @invoice_image.destroy
    redirect_to invoice_images_path, notice: 'Invoice Image Deleted'
  end


  private

  def invoice_image_params
    params
      .require(:invoice_image)
      .permit(:name, :image)
  end
end
