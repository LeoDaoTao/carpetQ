# == Schema Information
#
# Table name: discounts
#
#  id         :integer          not null, primary key
#  name       :string(20)
#  value      :decimal(, )
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class DiscountsController < ApplicationController
  def index
    @discounts = Discount.order(:value)
    @page_name = 'Discounts'
  end

  def new
    @discount = Discount.new
    @page_name = 'Add Discount'
  end

  def create
    @discount = Discount.new discount_params

    if @discount.save
      redirect_to discounts_path, notice: 'Discount Successfully Created'
    else
      @page_name = 'Add Discount'
      render :new
    end
  end

  def edit
    @discount = Discount.find(params[:id])
    @page_name = 'Edit Discount'
  end

  def update
    @discount = Discount.find(params[:id])

    if @discount.update(discount_params)
      redirect_to discounts_path, notice: 'Discount Successfully Updated'
    else
      @page_name = 'Edit Discount'
      render :edit, error: 'Plese correct all erorrs'
    end
  end

  def destroy
    @discount = Discount.find(params[:id])
    @discount.destroy
    redirect_to discounts_path, notice: 'Discount Deleted'
  end

  private

  def discount_params
    params.require(:discount)
          .permit(:name, :value)
  end
end
