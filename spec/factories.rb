FactoryGirl.define do

  sequence(:name) { |n| "Joe User #{n}"}
  sequence(:email) { |n| "johnhutch+user#{n}@gmail.com"}

  factory :user do
    email
    password 'secret'
  end

  sequence(:recipe_name) { |n| "Recipe Name #{n}"}
  factory :recipe do
    name { generate(:recipe_name) }
    ingredients_block "1/2 cup butter\n1/4 tsp salt\n1 gram sugar\n3 apples"
    steps "MyText"
    time 1
  end
  # generated via: rails g factory_girl:model Recipe name steps:text time:integer user_id:integer

  sequence(:meal_plan_name) { |n| "Meal Plan Name #{n}"}
  factory :meal_plan do
    name { generate(:meal_plan_name) }
    active 1
  end
end
