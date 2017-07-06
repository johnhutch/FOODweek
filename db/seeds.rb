# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Three users created, and then saved into variables for later use with creating recipes.
@test_user_paris = User.new(
  email: "jonathan.edward.hall@gmail.com",
  password: "whatever",
  password_confirmation: "whatever"
)
@test_user_paris.skip_confirmation!
@test_user_paris.save!

@test_user_hutch = User.new(
  email: "johnhutch@gmail.com",
  password: "whatever",
  password_confirmation: "whatever"
)
@test_user_hutch.skip_confirmation!
@test_user_hutch.save!

@test_user_sammy = User.new(
  email: "arbitrarynoun@gmail.com",
  password: "whatever",
  password_confirmation: "whatever"
)
@test_user_sammy.skip_confirmation!
@test_user_sammy.save!

# Multiple recipes created, assigned ownership to different users.
# The ~HEREDOC keyword allows for multi-line strings and does NOT include the indents! Isn't that great?
test_recipe_a_ingredients = <<~HEREDOC
1 lb ground beef
2 tbsp hot sauce
HEREDOC

test_recipe_a_steps = <<~HEREDOC
Add ingredients
Heat up mixture
HEREDOC

test_recipe_a = @test_user_paris.recipes.create(
  name: "Chili",
  time: 30,
  ingredients_block: test_recipe_a_ingredients,
  steps: test_recipe_a_steps
)

test_recipe_b_ingredients = <<~HEREDOC
1 lb of ground beef
1 onion
HEREDOC

test_recipe_b_steps = <<~HEREDOC
mash it all together in a ball
cook ball
HEREDOC

test_recipe_b = @test_user_hutch.recipes.create(
  name: "Meatball",
  time: 20,
  ingredients_block: test_recipe_b_ingredients,
  steps: test_recipe_b_steps
)

test_recipe_c_ingredients = <<~HEREDOC
1 tbsp hot sauce
1 tbsp cold sauce
HEREDOC

test_recipe_c_steps = <<~HEREDOC
mix sauces together
let sit
HEREDOC

test_recipe_c = @test_user_sammy.recipes.create(
  name: "Medium Sauce",
  time: 15,
  ingredients_block: test_recipe_c_ingredients,
  steps: test_recipe_c_steps
)

test_recipe_d_ingredients = <<~HEREDOC
4 tbsp sugar
2 tbsp salt
HEREDOC

test_recipe_d_steps = <<~HEREDOC
mix ingredients in a small bowl
dust under your nose
HEREDOC

test_recipe_d = @test_user_paris.recipes.create(
  name: "Sweet & Salty Dust",
  time: 30,
  ingredients_block: test_recipe_d_ingredients,
  steps: test_recipe_d_steps
)

test_recipe_e_ingredients = <<~HEREDOC
1 quart chicken stock
1 celery
1 carrot
1 onion
HEREDOC

test_recipe_e_steps = <<~HEREDOC
chop vegetables
heat up stock
add vegetables
stir
HEREDOC

test_recipe_e = @test_user_paris.recipes.create(
  name: "Mirepoix",
  time: 45,
  ingredients_block: test_recipe_e_ingredients,
  steps: test_recipe_e_steps
)

test_recipe_f_ingredients = <<~HEREDOC
1 bag lettuce
1 tomato
1 red onion
HEREDOC

test_recipe_f_steps = <<~HEREDOC
chop all ingredients
toss in bowl
HEREDOC

test_recipe_f = @test_user_hutch.recipes.create(
  name: "Generic Salad",
  time: 30,
  ingredients_block: test_recipe_f_ingredients,
  steps: test_recipe_f_steps
)

test_recipe_g_ingredients = <<~HEREDOC
3 tbsp cocoa
1 tbsp sugar
1 cup milk
HEREDOC

test_recipe_g_steps = <<~HEREDOC
mix dry ingredients
heat up milk
slowly stir in dry ingredients
HEREDOC

test_recipe_g = @test_user_sammy.recipes.create(
  name: "Hot Chocolate",
  time: 15,
  ingredients_block: test_recipe_g_ingredients,
  steps: test_recipe_g_steps
)
