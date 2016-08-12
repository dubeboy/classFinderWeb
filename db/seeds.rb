# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# 50.times { |t| Item.new(name: Faker::Name.name,
#                         price: Faker::Commerce.price,
#                         user_id: t,
#                         created_at: Faker::Time.between(2.days.ago, Date.today, :all),
#                         description: Faker::Lorem.paragraph(2),
#                         category_id: Faker::Number.number(1),
#                         views: Faker::Number.number(3),
#                         tot_likes: Faker::Number.number(3) )
#                    .save(validate: false
#                    ) }

Category.create(name: 'Electronics')
Category.create(name: 'Books')
Category.create(name: 'Other')
