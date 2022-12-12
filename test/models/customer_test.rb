# == Schema Information
#
# Table name: customers
#
#  id            :integer          not null, primary key
#  last_name     :string
#  first_name    :string
#  company_name  :string
#  phone_home    :string
#  phone_work    :string
#  phone_mobile1 :string
#  phone_mobile2 :string
#  email         :string
#  address       :string
#  city          :string
#  state         :string(2)
#  zip           :string
#  note          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

require 'test_helper'

class CustomerTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
