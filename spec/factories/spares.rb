FactoryGirl.define do
  factory :spare do |f|
    f.name { Faker::Lorem.word }
    equipment_type
  end
end