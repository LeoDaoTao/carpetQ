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

module InvoicesHelper
  def select_reminder_date
    date = Chronic.parse(date)
    date_format = '15 January, 2010'
    (Date.today + 3.months).stamp(date_format)
  end
end
