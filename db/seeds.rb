# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Recipe.create(name: "Chili", ingredients: "1 can of chili", steps: "*do this first*", time: 30)
Recipe.create(name: "Eggs", ingredients: "3 eggs", steps: "**this is bold baby do something**", time: 40)
Recipe.create(name: "Omelete", ingredients: "3 eggs", steps: "do stuff", time: 35)
