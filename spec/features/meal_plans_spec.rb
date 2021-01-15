require 'rails_helper'

RSpec.feature "Meal Plan", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe2) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe3) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe4) { FactoryGirl.create(:recipe, user: user1, ingredients_block: %Q|5 tbsp soy sauce
                                     4 tbsp mild or hot chili powder
                                     3 tbsp five-spice powder
                                     2 tbsp light muscovado sugar
                                     2 cloves garlic, finely chopped
                                     pinch of cayenne pepper
                                     splash of vinegar
                                     1 small bay leaf
                                     splash of extra virgin olive oil
                                     glug of soy sauce
                                     1 chicken
                                     1 leek
                                     1 small cauliflower
                                     1 shallot
                                     a stalk of celery
                                     pinches szechuan peppercorns
                                     1 clove []
                                     4 cm piece of fresh ginger, peeled and finely chopped
                                     6 1/2 lbs boneless pork shoulder, rind removed|) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user: user1) }

  describe "The meal plan show page" do
    it "tells you you don't have any meals in your meal plan" do 
      login(user1)

      visit meal_plan_path(mealplan1)
      expect(page).to have_selector('.test-no_recipes')
    end
  end

  describe "The new meal plan form" do
    it "creates a new meal_plan and sums ingredients in grocery list. Ingredient amounts are subtracted when a recipe is removed." do
        login(user1)
        recipe
        recipe2
        recipe3
        recipe4

        visit dashboard_path
        expect(page).to have_selector('.test__recipe-list-item')
        click_link('new-meal-plan-btn__user-scen-2')
        fill_in "meal_plan_name", :with => "My new meal plan"
        check("meal_plan_recipe_ids_" + recipe.id.to_s)
        check("meal_plan_recipe_ids_" + recipe3.id.to_s)
        check("meal_plan_recipe_ids_" + recipe4.id.to_s)
        click_button('submit_meal_plan')
        expect(page).to have_selector('section.test__grocery-list')
        click_link ('test-nav-grocery_list')
        expect(page).to have_content recipe.ingredients.last.name
        expect(page).to have_content recipe3.ingredients.last.name
        expect(page).to_not have_content recipe2.ingredients.last.name
        expect(page).to have_content "1 cup butter"
        expect(page).to have_content "1/2 teaspoons salt"
        visit recipe_path(recipe)
        click_button I18n.t('recipes.remove_from_mealplan')
        expect(page).to have_content I18n.t('meal_plans.removed_recipe')
        visit grocery_list_path
        expect(page).to have_content "1/2 cups butter"
        expect(page).to have_content "1/4 teaspoons salt"
        expect(page).to_not have_content recipe.ingredients.last.name
    end
  end
end
