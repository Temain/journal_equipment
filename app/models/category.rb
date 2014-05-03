class Category < ActiveRecord::Base
  has_many :equipment_types

  validates :name, presence: true
end
