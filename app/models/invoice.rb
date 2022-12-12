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

class Invoice < ActiveRecord::Base
  belongs_to :customer
  belongs_to :event
  has_many :invoice_items
  after_initialize :set_defaults, unless: :persisted?

  accepts_nested_attributes_for :invoice_items, reject_if: :all_blank, allow_destroy: true 

  strip_attributes collapse_spaces: true

  enum reminder_methods: Reminder.reminder_methods

  private

  def set_defaults
    self.date = Date.today
  end
end
