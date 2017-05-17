require 'rails_helper'

RSpec.feature "Meal Plan", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe2) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe3) { FactoryGirl.create(:recipe, user: user1) }
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
        recipe2
        recipe3

        visit dashboard_path
        expect(page).to have_selector('.test__recipe-list-item')
        click_link('new-meal-plan-btn__user-scen-2')
        fill_in "meal_plan_name", :with => "My new meal plan"
        check("meal_plan_recipe_ids_" + recipe.id.to_s)
        check("meal_plan_recipe_ids_" + recipe3.id.to_s)
        click_button('submit_meal_plan')
        expect(page).to have_selector('section.test__grocery-list')
        click_link ('test-nav-grocery_list')
        expect(page).to have_content recipe.ingredients.last.name
        expect(page).to have_content recipe3.ingredients.last.name
        expect(page).to_not have_content recipe2.ingredients.last.name
        expect(page).to have_content "1 cup butter"
        expect(page).to have_content "1/2 teaspoons salt"
    end
  end
end
