# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  login           :string
#  name            :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  has_secure_password

  validates :login, presence: true, uniqueness: { case_sensitive: false }
  validates :name, presence: true
end
