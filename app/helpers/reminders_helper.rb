# == Schema Information
#
# Table name: reminders
#
#  id              :integer          not null, primary key
#  date            :date
#  completed       :boolean          default(FALSE)
#  customer_id     :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  reminder_method :enum
#  error           :text
#
# Indexes
#
#  index_reminders_on_completed        (completed)
#  index_reminders_on_customer_id      (customer_id)
#  index_reminders_on_reminder_method  (reminder_method)
#
# Foreign Keys
#
#  fk_rails_d934f5a924  (customer_id => customers.id)
#

module RemindersHelper
end
