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
    end

    it "can be appended" do
      login(user1)
      mealplan1.recipes << recipe
      mealplan1.recipes << recipe2
      mealplan1.recipes << recipe3

      visit dashboard_path

      fill_in "new_ingredient", :with => "3 tbsp of butter"
      click_button I18n.t('recipes.submit_new')
      expect(page).to have_content I18n.t('grocery_list.ingredient_added')
    end

    it "can be edited"
    it "can be trimmed"
    it "reorganizes as you check items off it"
    it "can be added to from Alexa"
  end
end
