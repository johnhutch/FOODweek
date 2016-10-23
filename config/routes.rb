Rails.application.routes.draw do
  root "recipes#index"

  devise_for :users

  get "recipes/mine", to: "recipes#mine"
  resources :recipes

  get "dashboard", to: "dashboard#user"

  post "meal_plans(/:id)/add_recipe/:recipe_id", to: "meal_plans#add_recipe", as: "add_recipe_to_meal_plan"
  post "meal_plans(/:id)/remove_recipe/:recipe_id", to: "meal_plans#remove_recipe", as: "remove_recipe_from_meal_plan"
  resources :meal_plans
end
