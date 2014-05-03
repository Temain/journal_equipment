# == Schema Information
#
# Table name: relocations
#
#  id            :integer          not null, primary key
#  department_id :integer          not null
#

require 'spec_helper'

describe Relocation do
  it "has a valid factory" do
    FactoryGirl.create(:relocation).should be_valid
  end
end
