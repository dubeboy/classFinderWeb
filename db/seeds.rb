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

# Category.create(name: 'CellPhone', book_type: "NotBook")
# Category.create(name: 'Laptops', book_type: "NotBook")
# Category.create(name: 'Clothing', book_type: "NotBook")
# Category.create(name: 'PerFumes', book_type: "NotBook")
# Category.create(name: 'Bags And Accessories', book_type: "NotBook")

Category.create(name: 'Accomodation',book_type: "NotBook")
Category.create(name: 'Science',book_type: "Book")
Category.create(name: 'Engineering', book_type: "Book")
Category.create(name: 'Law', book_type: "Book")
Category.create(name: 'Architecture And Design', book_type: "Book")
Category.create(name: 'Education', book_type: "Book")
Category.create(name: 'Humanities', book_type: "Book")
Category.create(name: 'Medicine', book_type: "Book")


Institution.create(name: 'Wits', location: 'Bram')
Institution.create(name: 'UJ', location: 'Auckland Park')
Institution.create(name: 'UJ', location: 'DFC')
Institution.create(name: 'UJ', location: 'Soweto')

#todo for books add book category like MATH PHYSIC ETC