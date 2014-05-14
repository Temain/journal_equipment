# == Schema Information
#
# Table name: equipment_types
#
#  id          :integer          not null, primary key
#  name        :string(255)      not null
#  category_id :integer          not null
#

class EquipmentType < ActiveRecord::Base
  belongs_to :category
  has_many   :equipments
  has_many   :spares

  validates :name, presence: true, uniqueness: true
end
