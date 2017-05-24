Rails.application.routes.draw do
  root "content#home"

  devise_for :users

  resources :recipes
  get "recipes/mine", to: "recipes#mine"

  get "dashboard", to: "dashboard#user"

  resources :meal_plans
  patch "meal_plans/:id/add_recipe", to: "meal_plans#add_recipe", as: "add_recipe_to_meal_plan"
  patch "meal_plans/:id/remove_recipe", to: "meal_plans#remove_recipe", as: "remove_recipe_from_meal_plan"

  get "grocery_list", to: "grocery_list#index", as: "grocery_list"
  post "grocery_list/add_ingredient", to: "grocery_list#add_ingredient", as: "add_ingredient_to_grocery_list"

  get "/privacy" => "content#privacy"
  get "/style_guide" => "content#style_guide"
  get "/terms" => "content#terms"
  get "/contact" => "content#contact"
end
