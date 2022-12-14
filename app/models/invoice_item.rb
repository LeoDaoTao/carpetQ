# == Schema Information
#
# Table name: invoice_items
#
#  id          :integer          not null, primary key
#  description :string
#  dimensions  :string
#  unit_cost   :money
#  total_cost  :money
#  service_id  :integer
#  invoice_id  :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_invoice_items_on_invoice_id  (invoice_id)
#  index_invoice_items_on_service_id  (service_id)
#
# Foreign Keys
#
#  fk_rails_25bf3d2c5e  (invoice_id => invoices.id) ON DELETE => cascade
#  fk_rails_89beba9411  (service_id => services.id)
#

class InvoiceItem < ActiveRecord::Base
  belongs_to :service
  strip_attributes collapse_spaces: true
end
