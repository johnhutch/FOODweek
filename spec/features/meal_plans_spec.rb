require 'rails_helper'

RSpec.feature "Meal Plan", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user: user1) }

  describe "GET /meal_plans/1" do
    it " tells you you don't have any meals in your meal plan" do 
      login(user1)

      visit meal_plan_path(mealplan1)
      expect(page).to have_selector('.test-no_recipes')
    end
  end

  describe "GET /meal_plans/new" do
    it " it creates a new meal_plan via the new meal_plan web form" do
        login(user1)
        recipe

        visit dashboard_path
        page.has_css?('li.recipe-briefs__list-item')
        click_link('new_meal_plan')
        fill_in "Name", :with => "My new meal plan"
        check("meal_plan_recipe_ids_" + recipe.id.to_s)
        click_button('submit_meal_plan')
        page.has_css?('li.dashboard__ingredients_set')
    end
  end
end
