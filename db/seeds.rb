# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Cat.destroy_all
cat1 = Cat.create(birth_date:'2000/01/01', color:'White', description:"This is a big white fluffy cat",name:'Blanc', sex:"F")
cat2 = Cat.create(birth_date:'2000/02/01', color:'Black', description:"This is a big black fluffy cat",name:'Noir', sex:"F")

