FactoryGirl.define do
  factory :department do |f|
    f.name { Faker::Commerce.department }
    f.materially_responsible { Faker::Name.name }
    f.phone_number { Faker::PhoneNumber.subscriber_number(3) }
  end
end