Rails.application.routes.draw do
  root "recipes#index"

  devise_for :users

  get "recipes/mine", to: "recipes#mine"
  resources :recipes

  resources :meal_plans
end
