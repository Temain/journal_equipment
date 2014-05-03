# == Schema Information
#
# Table name: departments
#
#  id                     :integer          not null, primary key
#  name                   :string(255)      not null
#  materially_responsible :string(255)
#  phone_number           :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class Department < ActiveRecord::Base
  has_many :equipments

  validates :name, presence: true, uniqueness: true
end
