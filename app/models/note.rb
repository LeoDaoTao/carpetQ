# == Schema Information
#
# Table name: notes
#
#  id         :integer          not null, primary key
#  note_text  :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  status     :integer
#

class Note < ActiveRecord::Base
  enum status: [:booked, :messaged, :completed, :done]
  strip_attributes collapse_spaces: true
end
