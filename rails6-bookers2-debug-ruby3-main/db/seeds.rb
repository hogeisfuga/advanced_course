# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
(1..5).each do |i|
  User.create(name: "hoge#{i}", email: "hoge#{i}@example.com", password: "111111")
  Book.create(title: "book#{i}", body: "body#{i}", user_id: "#{i}")
end

(1..5).each do |i|
  BookComment.new(book_id: i, user_id: rand(1..5), comment: "{おすすめの書籍です}")
end

(1..5).each do |i|
  Favorite.create(user_id: i, book_id: i)
end
