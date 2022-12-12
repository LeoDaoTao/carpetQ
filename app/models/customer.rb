# == Schema Information
#
# Table name: customers
#
#  id            :integer          not null, primary key
#  last_name     :string
#  first_name    :string
#  company_name  :string
#  phone_home    :string
#  phone_work    :string
#  phone_mobile1 :string
#  phone_mobile2 :string
#  email         :string
#  address       :string
#  city          :string
#  state         :string(2)
#  zip           :string
#  note          :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Customer < ActiveRecord::Base
  has_many :phones, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :invoices, dependent: :destroy
  has_many :reminders, dependent: :destroy

  accepts_nested_attributes_for :phones, reject_if: :all_blank, allow_destroy: true 
  accepts_nested_attributes_for :addresses, reject_if: :all_blank, allow_destroy: true

  strip_attributes collapse_spaces: true

  # List Texable Numbers
  def phones_textable
    Phone.where(customer_id: self.id).where(textable: true)
  end

  def textable?
    self.phones_textable.present?
  end

  def deletable?
    !self.events.present? && !self.invoices.present?
  end

  def full_name
    unless self.last_name.empty? || self.last_name.empty?
      self.last_name + ", " + self.first_name
    else
      self.company_name
    end
  end

  def title
    if self.first_name? && self.last_name?
    
      return "#{self.first_name} #{self.last_name} [#{self.company_name}]" unless self.company_name.nil?
      return "#{self.first_name} #{self.last_name}"
    elsif self.company_name?
      self.company_name
    else
      'Appointment'
    end
  end

  def emailable?
    self.email.present?
  end
end
