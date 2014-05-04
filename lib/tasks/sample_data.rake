namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do

    # Create categories
    Category.create!(name: "Ноутбуки, планшеты и компьютеры")
    Category.create!(name: "Периферийные устройства")
    Category.create!(name: "Компьютерные аксессуары")

    # Create users
    #User.create!(name: "Example User",
    #             email: "example@mail.ru",
    #             password: "foobar",
    #             password_confirmation: "foobar")
    #99.times do |n|
    #  name = Faker::Name.name
    #  email = "example-#{n+1}@mail.ru"
    #  password = "password"
    #  User.create!(name: name,
    #               email: email,
    #               password: password,
    #               password_confirmation: password)
    #end
    #

    ## Create microposts
    #users = User.all().limit(6)
    #50.times do
    #  content = Faker::Lorem.sentence(1000)
    #  title = "Title"
    #  from = Time.now.to_f
    #  to = 2.years.from_now.to_f
    #  created_at = Time.at(from + rand * (to - from))
    #  users.each do |user|
    #    micropost = user.microposts.create!(content: content, title: title, created_at: created_at)
    #    offset = rand(Category.count)
    #    rand_category = Category.first(:offset => offset)
    #    micropost.categories << rand_category
    #  end
    #end
  end
end