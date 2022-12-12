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

class Discount < ActiveRecord::Base
  strip_attributes collapse_spaces: true

  validates_presence_of :name
end
