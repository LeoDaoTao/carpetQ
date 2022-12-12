# == Schema Information
#
# Table name: events
#
#  id          :integer          not null, primary key
#  date        :date
#  time_start  :time
#  time_end    :time
#  note        :text
#  customer_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  color       :string
#  description :string(100)
#  city        :string(30)
#  invoice_id  :integer
#
# Indexes
#
#  index_events_on_customer_id  (customer_id)
#  index_events_on_invoice_id   (invoice_id)
#
# Foreign Keys
#
#  fk_rails_37dc3a4c49  (customer_id => customers.id)
#  fk_rails_ca0b457a24  (invoice_id => invoices.id)
#

module EventsHelper
  def select_date(form, date)
    date = Chronic.parse(date)
    date_format = 'January 5, 2010'
    return form.object.date.stamp(date_format) if form.object.date.present?
    return date.stamp(date_format) if date.present?
    Date.today.stamp(date_format)
  end

  def select_time_start(form, date)
    date = Chronic.parse(date)
    time_format = '7:00am'
    return form.object.time_start.stamp(time_format) if form.object.time_start.present?
    return date.stamp(time_format) if date.present?
    '8:00am'
  end

  def select_time_end(form, time)
    time_format = '7:00am'
    return form.object.time_end.stamp(time_format) if form.object.time_end.present?
    time = Chronic.parse(time)
    return time.stamp(time_format) if time.present?
    '10:00am'
  end

  def get_customer_id(form, customer_id)
    return form.object.customer_id if form.object.customer_id.present?
    return customer_id if customer_id.present?
    ''
  end
end
