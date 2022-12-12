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

class Phone < ActiveRecord::Base
  belongs_to :customer
  strip_attributes collapse_spaces: true

  validates_presence_of :number, :label 

  def mobile?
    self.label == 'mobile' || self.label == 'cell'
  end
end
