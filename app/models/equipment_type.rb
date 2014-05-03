# == Schema Information
#
# Table name: equipment_types
#
#  id           :integer          not null, primary key
#  name         :string(255)      not null
#  category_id  :integer          not null
#  manufacturer :string(255)      not null
#  abbreviation :string(255)
#

class EquipmentType < ActiveRecord::Base
  belongs_to :category
  has_many   :equipments

  validates :name, presence: true, uniqueness: true
  validates :manufacturer, presence: true
end
