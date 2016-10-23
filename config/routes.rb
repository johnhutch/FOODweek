Rails.application.routes.draw do
  root "recipes#index"

  devise_for :users

  get "recipes/mine", to: "recipes#mine"
  resources :recipes

  get "dashboard", to: "dashboard#user"

  post "meal_plan/:id/add_recipe", to: "meal_plan#add_recipe", as: "meal_plan_add_recipe"
  post "meal_plan/:id/remove_recipe", to: "meal_plan#remove_recipe", as: "meal_plan_remove_recipe"
  resources :meal_plans
end
