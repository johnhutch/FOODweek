class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy] 
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :mine]

  def show
    @meal_plan = current_user.meal_plans.last

    if @meal_plan.nil?
      @meal_plan = current_user.meal_plans.build(name: "Unnamed Meal Plan")
      @meal_plan.save
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
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: "Your recipe has been updated." }
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
    params.require(:recipe).permit(:name, :ingredients, :steps, :time)
  end
end
