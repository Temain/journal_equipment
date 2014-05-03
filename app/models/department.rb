class Department < ActiveRecord::Base
  has_many :equipments

  validates :name, presence: true, uniqueness: true
end
