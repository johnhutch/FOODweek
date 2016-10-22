Rails.application.routes.draw do
  resources :meal_plans
  devise_for :users
  root 'recipes#index'

  resources :recipes
end
