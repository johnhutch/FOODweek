Rails.application.routes.draw do
  root "recipes#index"

  devise_for :users

  get "recipes/mine", to: "recipes#mine"
  resources :recipes

  get "dashboard", to: "dashboard#user"

  post "add_recipe_to_meal_plan/:id", to: "meal_plan#add_recipe"
  post "remove_recipe_from_meal_plan/:id", to: "meal_plan#remove_recipe"
  resources :meal_plans
end
