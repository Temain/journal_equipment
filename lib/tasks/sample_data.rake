require 'bcrypt'

namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create categories
    Category.create!(name: "Ноутбуки, планшеты и компьютеры")
    Category.create!(name: "Периферийные устройства")
    Category.create!(name: "Компьютерные аксессуары")

    # Create departments
    10.times do |n|
      Department.create!(name:                   "#{Faker::Commerce.department} ##{n + 1}",
                         materially_responsible: Faker::Name.name,
                         phone_number:           Faker::PhoneNumber.subscriber_number(3)
      )
    end

    # Create equipment types
    10.times do |n|
      EquipmentType.create!(name:         "#{Faker::Commerce.product_name} ##{n}",
                            category_id:  rand(1..Category.count),
                            manufacturer: Faker::Company.name,
                            abbreviation: "ABBA"
      )
    end

    # Create equipment types
    20.times do
      Equipment.create!(equipment_type_id: rand(1..EquipmentType.count),
                        department_id:     rand(1..Department.count),
                        inventory_number:  Faker::Number.number(11)
      )
    end

    # Create relocation actions and save it in journal records table
    30.times do
      relocation = Relocation.create!(department_id: rand(1..Department.count))

      from = Time.now.to_f
      to = 3.months.from_now.to_f
      created_at = Time.at(from + rand * (to - from))
      relocation.create_journal_record(equipment_id:  rand(1..Equipment.count),
                                       note:          Faker::Lorem.sentence,
                                       created_at:    created_at
      )
    end

    # Create spares
    20.times do |n|
      Spare.create!(name:              "#{Faker::Lorem.word} ##{n}",
                    equipment_type_id: rand(1..EquipmentType.count)
      )
    end

    # Create repair actions and save it in journal records table
    30.times do
      repair = Repair.create!(spare_id: rand(1..Spare.count),
                              reason:   Faker::Lorem.sentence
      )

      from = Time.now.to_f
      to = 3.months.from_now.to_f
      created_at = Time.at(from + rand * (to - from))
      repair.create_journal_record(equipment_id:  rand(1..Equipment.count),
                                   note:          Faker::Lorem.sentence,
                                   created_at:    created_at
      )
    end

    # Create users
    User.create!(email:                 "temain@mail.ru",
                 password:              "12345678",
                 password_confirmation: "12345678")
  end
end