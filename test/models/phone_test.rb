# == Schema Information
#
# Table name: phones
#
#  id          :integer          not null, primary key
#  number      :string(20)       not null
#  label       :string(20)       not null
#  textable    :boolean          default(FALSE)
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_phones_on_customer_id  (customer_id)
#
# Foreign Keys
#
#  fk_rails_4588ed0a89  (customer_id => customers.id)
#

require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
