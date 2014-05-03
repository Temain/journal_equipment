FactoryGirl.define do
  factory :relocation do |f|
    department
    #f.after_create {|r| FactoryGirl.create(:journal_record, :journalable => r)}
  end
end