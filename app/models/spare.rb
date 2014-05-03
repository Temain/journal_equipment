# == Schema Information
#
# Table name: spares
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  category_id :integer
#

class Spare < ActiveRecord::Base
  belongs_to :equipment_type
  has_many   :repairs

  validates :name, presence: true, uniqueness: true
end
