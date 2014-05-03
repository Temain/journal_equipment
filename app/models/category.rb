class Category < ActiveRecord::Base
  has_many :equipment_types
end
