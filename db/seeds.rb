# # This file should contain all the record creation needed to seed the database with its default values.
# # The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
# #
# # Examples:
# #
# #   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
# #   Character.create(name: 'Luke', movie: movies.first)

if User.find_by(email: "jul33anc@gmail.com").portfolio
  User.find_by(email: "jul33anc@gmail.com").portfolio.destroy
end
User.find_by(email: "jul33anc@gmail.com").destroy

Currency.update_data(200)
User.create(first_name:"Julien", last_name:"Anceau", email: "jul33anc@gmail.com", password: "123456")
