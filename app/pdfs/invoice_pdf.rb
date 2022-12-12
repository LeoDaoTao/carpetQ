class InvoicePdf < Prawn::Document
  def initialize(invoice, view)
    super()
    @invoice = invoice
    @view = view
    customer_name
    address
    phones
    email
    service_date
    #logo
    slogan
    contact
    line_items
    totals_table
    note
    divider
    disclaimer
  end

  def customer_name
    text @invoice.customer.title, size: 16, style: :bold
  end

  def address
    move_down 5
    text @invoice.customer.address
    text "#{@invoice.customer.city}, #{@invoice.customer.state} #{@invoice.customer.zip}"
  end

  def phones
    move_down 5
    @invoice.customer.phones.each do |phone|
    text "#{phone.label}: #{format_tel(phone.number)}"
    end
  end

  def email
    move_down 5
    text "email: #{@invoice.customer.email}"
  end

  def service_date
    move_down 28
    text "Service Date: #{@invoice.date.stamp('Jan 5, 2010')} - #{@invoice.service_time.stamp('8:00am')}",
         style: :bold
  end

  def line_items
   move_down 40 
   table(line_items_rows, column_widths: [120, 180, 100, 70, 70]) do
     row(0).font_style = :bold
     columns(3..4).align = :right
     self.header = true
   end
  end

  def line_items_rows
    [['Service', 'Description', 'Dimensions', 'Unit Cost', 'Total Cost']] +
    @invoice.invoice_items.map do |item|
      [service_name(item.service_id), item.description, item.dimensions, currency(item.unit_cost), currency(item.total_cost)]
    end
  end

  def totals_table
    discount_label = discount_name(@invoice.discount_id) if @invoice.discount_id.present?
    data = [
      ['Discount:', discount_label],
      ['Grand Total:', currency(@invoice.total)]
    ]
    table data, column_widths: [170, 70], position: :right do 
      columns(1).align = :right
      columns(1).font_style = :bold
    end
  end

  def disclaimer
    disclaimer_text = '**Please Note: Any check returned by the bank/institution for non-payment is subject to a $25 fee. Funds to cover returned check + fee will be taken only in form of cash/money order or credit card. We are no longer able to redeposit a returned check.'

    disclaimer_text = disclaimer_text.upcase

    text_box disclaimer_text,
             at: [5, 35],
             width: 540,
             height: 30, 
             align: :center,
             style: :bold,
             size: 8
  end

  def note
    if @invoice.note.present?
      text_box @invoice.note,
               at: [5, cursor - 10],
               width: 535,
               style: :bold,
               size: 10
    end
  end

  def divider
    stroke do
      horizontal_line 5, 540, at: 50
    end
  end
  
  private 

  def service_name(id)
    Service.find(id).name
  end

  def discount_name(id)
    Discount.find(id).name
  end

  def currency(number)
    @view.number_to_currency(number)
  end
  
  def format_tel(number)
    @view.number_to_phone(number, area_code: true)
  end

  def logo
    image "#{Rails.root}/app/assets#{ActionController::Base.helpers.asset_path('images/pdf_logo.png')}",
          at: [280, 730]
  end

  def slogan
    text_box "CARPET - UPHOLSTERY - TILE & GROUT CLEANING",
             at: [260, 640],
             width: 280,
             height: 30, 
             align: :center,
             style: :bold
  end

  def contact
    text_box "(626) 689-4312 www.roosterbot.com",
             at: [260, 610],
             width: 280,
             height: 50,
             align: :center,
             style: :bold,
             size: 16
  end
end
