class Relocations < ActiveRecord::Base
  belongs_to :department
  has_many :journals, as: :journalable
end
