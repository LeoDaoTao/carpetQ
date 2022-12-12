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

class Reminder < ActiveRecord::Base
  belongs_to :customer

  validates_presence_of :date, :reminder_method, :customer_id
  strip_attributes

  enum reminder_method: {
    txt: 'TXT',
    email: 'EMAIL',
    phone: 'PHONE'
  }

  def self.add(customer_id:, date:, reminder_method:)
    Reminder.create(
      customer_id: customer_id,
      date: date,
      reminder_method: reminder_method
    )
  end

  def self.completed
    self.where(completed: true)
  end

  def self.not_completed
    self.where(completed: false)
  end

  def self.until_today
    self.where('date <= ?', Date.today)
  end
end
