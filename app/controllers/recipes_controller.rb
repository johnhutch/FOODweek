class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy] 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :mine]

  def show
    if user_signed_in?
      @meal_plan = current_user.current_meal_plan

      if @meal_plan.nil?
        @meal_plan = current_user.meal_plans.build(name: "Unnamed Meal Plan")
        @meal_plan.save
      end
    end
  end

  def index
    @recipes = Recipe.all
  end

  def mine
    @recipes = current_user.recipes.all
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: t('recipes.new_saved') }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
  end

  def update
    old_ingredients = @recipe.ingredients_block
    respond_to do |format|
      if @recipe.update(recipe_params)
        # don't bother re-parsing the ingredients if they haven't changed
        unless old_ingredients == @recipe.ingredients_block
          @recipe.parse_ingredient_block
        end
        format.html { redirect_to @recipe, notice: t('recipes.edit_saved') }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_path, notice: "That recipe has now been destroyed." }
      format.json { header :no_content }
    end
  end

  private
 
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :link, :ingredients_block, :steps, :time)
  end
end
