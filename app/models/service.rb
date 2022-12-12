# == Schema Information
#
# Table name: services
#
#  id         :integer          not null, primary key
#  name       :string
#  price      :money
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Service < ActiveRecord::Base
  validates_presence_of :name
end
