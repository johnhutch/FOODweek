class GroceryListController < ApplicationController
  before_action :authenticate_user!, only: [:add_ingredient, :index]

  def index
    @grocery_list = current_user.grocery_list
  end

  def add_ingredient
    @grocery_list = current_user.grocery_list
    @ingredient =  Ingredient.new
    @ingredient.ingreedy_parse(ingredient_params)

    respond_to do |format|
      if @grocery_list.ingredients << @ingredient
        format.html { render :index, notice: @ingredient.name + t('grocery_list.ingredient_added') }
        format.json { render :index, status: :ok, location: grocery_list_path }
      else
        format.html { render :index }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_string)
  end
end
