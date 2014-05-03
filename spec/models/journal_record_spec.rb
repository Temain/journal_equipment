require 'spec_helper'

describe JournalRecord do
  it "has a valid factory" do
    FactoryGirl.create(:journal_record).should be_valid
  end
end
