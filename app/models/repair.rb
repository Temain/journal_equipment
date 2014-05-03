# == Schema Information
#
# Table name: repairs
#
#  id               :integer          not null, primary key
#  replaced_item_id :integer
#  reason           :string(255)
#

class Repair < ActiveRecord::Base
  belongs_to :spare
  has_one    :journal_record, as: :journalable
end
