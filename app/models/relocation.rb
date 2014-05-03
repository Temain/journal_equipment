# == Schema Information
#
# Table name: relocations
#
#  id            :integer          not null, primary key
#  department_id :integer          not null
#

class Relocation < ActiveRecord::Base
  belongs_to :department
  has_one    :journal_record, as: :journalable
end
