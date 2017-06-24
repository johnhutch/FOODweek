class DashboardController < ApplicationController
  before_action :authenticate_user!

  def user
    @meal_plan = current_user.meal_plans.last
    @grocery_list = current_user.grocery_list || current_user.create_grocery_list
  end
end
