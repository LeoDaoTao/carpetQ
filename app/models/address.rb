# == Schema Information
#
# Table name: addresses
#
#  id          :integer          not null, primary key
#  label       :string(50)
#  address     :string
#  city        :string(30)
#  state       :string(2)        default("CA")
#  zip         :string(10)
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_addresses_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_d5f9efddd3  (customer_id => customers.id)
#

class Address < ActiveRecord::Base
  belongs_to :customer
  strip_attributes collapse_spaces: true

  validates_presence_of :label, :address, :city, :zip
end
