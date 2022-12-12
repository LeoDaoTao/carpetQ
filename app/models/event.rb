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

class Event < ActiveRecord::Base
  belongs_to :customer
  has_one :invoice
  strip_attributes

  WORK_TIME = %w(
    6:00am 6:15am 6:30am 6:45am
    7:00am 7:15am 7:30am 7:45am
    8:00am 8:15am 8:30am 8:45am
    9:00am 9:15am 9:30am 9:45am
    10:00am 10:15am 10:30am 10:45am
    11:00am 11:15am 11:30am 11:45am
    12:00pm 12:15pm 12:30pm 12:45pm
    1:00pm 1:15pm 1:30pm 1:45pm
    2:00pm 2:15pm 2:30pm 2:45pm
    3:00pm 3:15pm 3:30pm 3:45pm
    4:00pm 4:15pm 4:30pm 4:45pm
    5:00pm 5:15pm 5:30pm 5:45pm
    6:00pm 6:15pm 6:30pm 6:45pm
    7:00pm 7:15pm 7:30pm 7:45pm
    8:00pm 8:15pm 8:30pm 8:45pm
    9:00pm 9:15pm 9:30pm 9:45pm
    10:00pm
  )

  EVENT_COLORS = [
    [ 'Coral', 'Business' ],
    [ 'LightBlue ', 'Canceled' ],
    [ 'Magenta', 'Personal' ],
    [ 'MediumBlue','Marketing' ],
    [ 'LightGreen', 'Paperwork' ]

  ]

  def self.today
    Event.where(date: Date.today)
  end

  def invoiced?
    self.invoice_id.present?
  end

  def deletable?
    !self.invoiced?
  end

  def serialize
    event_title = if self.customer.nil?
                    self.description.present? ? self.description : "Appointment"
                  else
                    self.customer.title
                  end

    event_city = ''
    event_city = self.customer.city if self.customer.present?
    event_city = self.city if self.city.present?

    phones = []
    if self.customer.present?
      self.customer.phones.each do |phone|
        label = if phone.textable?
                  "#{phone.label} (textable)"
                else
                  phone.label
                end

        phones << [phone.number, label]
      end
    end


    address = if self.customer.present?
                "#{self.customer.address}, #{self.customer.city}, #{self.customer.state}, #{self.customer.zip}"
              elsif self.city.present?
                self.city
              else
                ''
              end


    event_color = 'Coral' 
    event_color = self.color if self.color.present?
    {
      id: self.id,
      title: event_title,
      date: self.date.strftime("%A, %B %e, %Y"),
      time: "#{self.time_start.strftime("%I:%M%P")} - #{self.time_end.strftime("%I:%M%P")}",
      start: "#{self.date} #{self.time_start.strftime("%H:%M")}",
      end: "#{self.date} #{self.time_end.strftime("%H:%M")}",
      edit_url: "/events/#{self.id}/edit",
      backgroundColor: event_color,
      city: event_city,
      phones: phones,
      address: address,
      invoice_id: self.invoice_id
    }
  end
end
