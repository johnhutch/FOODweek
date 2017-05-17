Rails.application.routes.draw do
  root "content#home"

  devise_for :users

  get "recipes/mine", to: "recipes#mine"
  resources :recipes

  get "dashboard", to: "dashboard#user"

  patch "meal_plans/:id/add_recipe", to: "meal_plans#add_recipe", as: "add_recipe_to_meal_plan"
  patch "meal_plans/:id/remove_recipe", to: "meal_plans#remove_recipe", as: "remove_recipe_from_meal_plan"
  resources :meal_plans

  get "/privacy" => "content#privacy"
  get "/style_guide" => "content#style_guide"
  get "/terms" => "content#terms"
  get "/contact" => "content#contact"
  get "/grocery_list" => "content#grocery_list"
end
