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

require 'test_helper'

class NotesControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
end
