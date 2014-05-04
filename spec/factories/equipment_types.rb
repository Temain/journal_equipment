FactoryGirl.define do
  factory :equipment_type do |f|
    f.name { Faker::Commerce.product_name }
    category
    f.manufacturer { Faker::Company.name }
    f.abbreviation "ABBA"
    #association :category, factory: :category, strategy: :build
  end
end