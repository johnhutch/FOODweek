class DashboardController < ApplicationController
  before_action :authenticate_user!

  def user
    @meal_plan = current_user.meal_plans.last
  end
end
