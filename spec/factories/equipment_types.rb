FactoryGirl.define do
  factory :equipment_type do |f|
    f.name { Faker::Commerce.product_name }
    category
    f.manufacturer { Faker::Company.name }
    f.abbreviation "ABBA"
  end
end