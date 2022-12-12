# == Schema Information
#
# Table name: labels
#
#  id            :integer          not null, primary key
#  name          :string
#  top_margin    :decimal(, )
#  bottom_margin :decimal(, )
#  left_margin   :decimal(, )
#  right_margin  :decimal(, )
#  columns       :integer
#  rows          :integer
#  column_gutter :decimal(, )
#  row_gutter    :decimal(, )
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class LabelsController < ApplicationController
  # This controller is used to handle the cration of PDF address label sheets
  #
  def index
    @page_name = 'Labels'
    @labels = Label.order :name
  end

  def new
    @page_name = 'New Label'
    @label = Label.new
  end

  def create
    @label = Label.new label_params

    if @label.save
      redirect_to labels_path, notice: 'Label Created'
    else
      @page_name = 'New label'
      render :new
    end
  end

  def edit
    @label = Label.find params[:id]
    @page_name = @label.name
  end

  def update
    @label = Label.find params[:id]
    if @label.update label_params
      redirect_to labels_path, notice: 'Label Updated'
    else
      render :new
    end
  end

  def addresses
    customers = Customer.order :last_name
    label = Label.find params[:label]

    Prawn::Labels.types = {
      'custom_label' => {
        "paper_size"    => "LETTER",
        "top_margin"    => label.top_margin * 72,
        "bottom_margin" => label.bottom_margin * 72,
        "left_margin"   => label.left_margin * 72,
        "right_margin"  => label.right_margin * 72,
        "columns"       => label.columns,
        "rows"          => label.rows,
        "column_gutter" => label.column_gutter * 72,
        :shrink_to_fit  => true
      }}

    addresses = []
    customers.each do |customer|
      address = ''
      address << "\n"
      address << customer.company_name if customer.company_name.present?
      address << "\n" if customer.company_name.present?
      address << customer.first_name if customer.first_name.present?
      address << ' ' if customer.first_name.present?
      address << customer.last_name if customer.last_name.present?
      address << "\n" if customer.first_name.present? || customer.last_name.present? 
      address << "#{customer.address}\n" if customer.address.present?
      address << "#{customer.city}, #{customer.state} #{customer.zip}"

      addresses << address
    end

    labels = Prawn::Labels.render(addresses, :type => 'custom_label', shrink_to_fit: true) do |pdf, name|
      pdf.text name
    end

    send_data labels, :filename => "carpet_addresses.pdf", :type => "application/pdf"
  end


  private

  def label_params
    params
      .require(:label)
      .permit(:name, :top_margin, :bottom_margin, :left_margin,
              :right_margin, :columns, :rows, :column_gutter, :row_gutter)
  end
end
