# == Schema Information
#
# Table name: equipment
#
#  id                :integer          not null, primary key
#  equipment_type_id :integer          not null
#  department_id     :integer          not null
#  inventory_number  :integer
#  writed_off        :boolean          default(FALSE)
#  created_at        :datetime
#  updated_at        :datetime
#  manufacturer_id   :integer
#  model             :string(255)
#

class Equipment < ActiveRecord::Base
  belongs_to :department
  belongs_to :equipment_type
  belongs_to :manufacturer
  has_many   :journal_records


    def full_name
      "#{equipment_type.name} #{manufacturer.name} #{model}"
    end
end
