class Equipment < ActiveRecord::Base
  belongs_to :department
  belongs_to :equipment_type
  has_many   :journals
end
