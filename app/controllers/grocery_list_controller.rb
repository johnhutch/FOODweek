class GroceryListController < ApplicationController
  before_action :authenticate_user!, only: [:add_ingredient, :index]

  def index
    @grocery_list = current_user.grocery_list

    respond_to do |format|
      format.html { render layout: "basic" }
      format.json { render json: @grocery_list }
    end
  end

  def add_ingredient
    @grocery_list = current_user.grocery_list
    @ingredient =  Ingredient.new
    @ingredient.ingreedy_parse(ingredient_params[:ingredient_string])

    respond_to do |format|
      if @grocery_list.add_ingredient(@ingredient)
        format.html { redirect_back(fallback_location: dashboard_path, notice: @ingredient.name + t('grocery_list.ingredient_added')) }
        format.json { redirect_back(fallback_location: dashboard_path, status: :ok, location: grocery_list_path) }
      else
        format.html { redirect_back(fallback_location: dashboard_path, notice: t('grocery_list.problem_adding_ingredient')) }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_string)
  end
end
