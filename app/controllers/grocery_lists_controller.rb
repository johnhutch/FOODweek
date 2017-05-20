class GroceryListsController < ApplicationController
  before_action :authenticate_user!, only: [:add_ingredient]

  def add_ingredient
    @grocery_list = current_user.grocery_list
    #@ingredient =  new_general_ingredient_parsing_fn

    respond_to do |format|
      if @grocery_list.ingredients << @ingredient
        format.html { redirect_to grocery_list_path, notice: @ingredient.name + t('grocery_list.ingredient_added') }
        format.json { render :show, status: :ok, location: grocery_list_path }
      else
        format.html { redirect_to grocery_list_path }
        format.json { render json: @ingredient.errors, status: :unprocessable_entity }
      end
    end
  end

  def ingredient_params
    params.require(:ingredient).permit(:ingredient_string)
  end
end
