# == Schema Information
#
# Table name: equipment
#
#  id                :integer          not null, primary key
#  equipment_type_id :integer          not null
#  department_id     :integer          not null
#  inventory_number  :integer
#  writed_off        :boolean          default(FALSE)
#  created_at        :datetime
#  updated_at        :datetime
#

require 'spec_helper'

describe Equipment do
  subject(:equipment) { FactoryGirl.create(:equipment) }

  it "has a valid factory" do
    equipment.should be_valid
  end

  it "should has writed off FALSE by default" do
    equipment.writed_off == false
  end
end
