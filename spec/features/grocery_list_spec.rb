require 'rails_helper'

RSpec.feature "GroceryList", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe2) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe3) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user_id: user1.id) }

  describe "A user's grocery list" do

    it "shows you aggregated ingredients from all the recipes in your meal plan" do
      login(user1)
      mealplan1.recipes << recipe
      mealplan1.recipes << recipe2
      mealplan1.recipes << recipe3

      visit grocery_list_path
      expect(page).to have_content ("1 1/2 cups butter")
      expect(page).to have_content ("3/4 teaspoons salt")
      expect(page).to have_content ("3 grams sugar")
    end

    context "on the dashboard" do
      it "can be appended" do
        login(user1)
        mealplan1.recipes << recipe

        visit dashboard_path
        fill_in "ingredient_ingredient_string", :with => "3 tbsp of butter"
        click_button I18n.t('ingredients.add_new')
        expect(page).to have_content I18n.t('grocery_list.ingredient_added')
        expect(page).to have_content ("11/16 cups butter")
      end

      it "doesn't crash if adding a unitless ingredient to a unit'd ingredient" do
        #e.g., adding "3 steaks" to "16 oz of steak" is ok
        login(user1)
        mealplan1.recipes << recipe

        visit dashboard_path

        fill_in "ingredient_ingredient_string", :with => "3 pounds of apple"
        click_button I18n.t('ingredients.add_new')
        expect(page).to have_content I18n.t('grocery_list.ingredient_added')
        expect(page).to have_content ("3 pounds apple")
        expect(page).to have_content ("3 apples")

        fill_in "ingredient_ingredient_string", :with => "1 salt"
        click_button I18n.t('ingredients.add_new')
        expect(page).to have_content I18n.t('grocery_list.ingredient_added')
        expect(page).to have_content ("1 salt")
      end
    end

  end
end
