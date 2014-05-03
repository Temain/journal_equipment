FactoryGirl.define do
  factory :repair do |f|
    spare
    f.reason { Faker::Lorem.sentence }
  end
end