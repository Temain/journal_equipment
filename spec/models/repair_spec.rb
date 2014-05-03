# == Schema Information
#
# Table name: repairs
#
#  id               :integer          not null, primary key
#  replaced_item_id :integer
#  reason           :string(255)
#

require 'spec_helper'

describe Repair do
  it "has a valid factory" do
    FactoryGirl.create(:repair).should be_valid
  end
end
