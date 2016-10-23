class ContentController < ApplicationController
  before_action :authenticate_user!, only: [:grocery_list]

  def home
  end

  def contact
  end

  def terms
  end

  def privacy
  end
  
  def style_guide
  end

  def grocery_list
    @meal_plan = current_user.meal_plans.last
    @grocery_list = @meal_plan.grocery_list if @meal_plan.present?

    respond_to do |format|
      if @grocery_list.present?
        format.html { render layout: "basic" }
        format.json { render json: @grocery_list }
      else
        format.html { redirect_to dashboard_path, alert: "No grocery list found, you must not have a meal plan yet." }
        format.json { head :no_content }
      end
    end
  end
end
