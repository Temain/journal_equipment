class EquipmentType < ActiveRecord::Base
  belongs_to :category
  has_many   :equipments

  validates :name, presence: true
  validates :manufacturer, presence: true
end
