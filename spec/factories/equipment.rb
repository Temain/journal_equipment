FactoryGirl.define do
  factory :equipment do |f|
    equipment_type
    department
    f.inventory_number { Faker::Number.number(11) }
  end
end