class GroceryListController < ApplicationController
  before_action :authenticate_user!, only: [:add_ingredient, :remove_ingredient, :index]
  before_action :set_grocery_list, only: [:index, :add_ingredient, :remove_ingredient]
  before_action :set_ingredient, only: [:remove_ingredient]

  def index
    respond_to do |format|
      format.html { render layout: "basic" }
      format.json { render json: @grocery_list }
    end
  end

  def add_ingredient
    @ingredient =  Ingredient.new
    @ingredient.ingreedy_parse(ingredient_params[:ingredient_string])

    respond_to do |format|
      if @grocery_list.add_ingredient(@ingredient)
        format.html { redirect_back(fallback_location: dashboard_path, success: "#{@ingredient.name} #{t('grocery_list.ingredient_added')}" ) }
        format.json { redirect_back(fallback_location: dashboard_path, status: :ok, location: grocery_list_path) }
      else
        format.html { redirect_back(fallback_location: dashboard_path, notice: t('grocery_list.problem_adding_ingredient')) }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_ingredient
    respond_to do |format|
      if @grocery_list.subtract_ingredient(@ingredient)
        format.html { redirect_back(fallback_location: dashboard_path, success: "#{@ingredient.name} #{t('grocery_list.ingredient_removed')}" ) }
        format.json { redirect_back(fallback_location: dashboard_path, status: :ok, location: grocery_list_path) }
      else
        format.html { redirect_back(fallback_location: dashboard_path, notice: t('grocery_list.problem_adding_ingredient')) }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_string, :id)
  end

  def set_grocery_list
    @grocery_list = current_user.grocery_list
  end

  def set_ingredient
    @ingredient = Ingredient.find(params[:id])
  end
end
