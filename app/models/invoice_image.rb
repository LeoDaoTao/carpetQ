# == Schema Information
#
# Table name: invoice_images
#
#  id                 :integer          not null, primary key
#  name               :string
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class InvoiceImage < ActiveRecord::Base
  has_attached_file :image, styles: { small: '32x32', large: '1500x1500' }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_presence_of :name, :image

  strip_attributes
end
