# == Schema Information
#
# Table name: manufacturers
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  abbreviation :string(255)
#

class Manufacturer < ActiveRecord::Base
  has_many :equipments
  validates :name, presence: true, uniqueness: true
end
