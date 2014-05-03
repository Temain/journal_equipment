class JournalRecord < ActiveRecord::Base
  belongs_to :equipment
  belongs_to :journalable, polymorphic: true
end
