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

require 'test_helper'

class LabelTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
