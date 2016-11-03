class MealPlansController < ApplicationController
  before_action :set_meal_plan, only: [:show, :edit, :update, :destroy, :add_recipe, :remove_recipe]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy, :add_recipe, :remove_recipe]

  # GET /meal_plans
  # GET /meal_plans.json
  def index
    @meal_plans = MealPlan.all
  end

  # GET /meal_plans/1
  # GET /meal_plans/1.json
  def show
  end

  # GET /meal_plans/new
  def new
    @meal_plan = MealPlan.new
  end

  # GET /meal_plans/1/edit
  def edit
  end

  # POST /meal_plans
  # POST /meal_plans.json
  def create
    @meal_plan = current_user.meal_plans.build(meal_plan_params)

    respond_to do |format|
      if @meal_plan.save
        format.html { redirect_to dashboard_path, notice: 'Meal plan was successfully created.' }
        format.json { render :show, status: :created, location: @meal_plan }
      else
        format.html { render :new }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /meal_plans/1
  # PATCH/PUT /meal_plans/1.json
  def update
    respond_to do |format|
      if @meal_plan.update(meal_plan_params)
        format.html { redirect_to dashboard_path, notice: "Meal plan was successfully updated." }
        format.json { render :show, status: :ok, location: @meal_plan }
      else
        format.html { render :edit }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /meal_plans/1
  # DELETE /meal_plans/1.json
  def destroy
    @meal_plan.destroy
    respond_to do |format|
      format.html { redirect_to dashboard_path, notice: "Meal plan was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_recipe
    @recipe = Recipe.find(params[:recipe_id])
    respond_to do |format|
      if @meal_plan.recipes << @recipe
        format.html { redirect_to @recipe, notice: t('meal_plans.added_recipe') }
        format.json { render :show, status: :ok, location: @meal_plan }
      else
        format.html { redirect_to :show }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  def remove_recipe
    @recipe = Recipe.find(params[:recipe_id])
    respond_to do |format|
      if @meal_plan.recipes.delete(@recipe)
        format.html { redirect_to @recipe, notice: t('meal_plans.removed_recipe') }
        format.json { render :show, status: :ok, location: @meal_plan }
      else
        format.html { redirect_to @recipe }
        format.json { render json: @meal_plan.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_meal_plan
    @meal_plan = MealPlan.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def meal_plan_params
    params.require(:meal_plan).permit(:name, :active, :recipe_id, { :recipe_ids => [] } )
  end
end
