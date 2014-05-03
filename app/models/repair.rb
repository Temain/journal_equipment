class Repair < ActiveRecord::Base
  belongs_to :spares
  has_many   :journals, as: :journalable
end
