class EquipmentType < ActiveRecord::Base
  belongs_to :category
  has_many   :equipments
end
