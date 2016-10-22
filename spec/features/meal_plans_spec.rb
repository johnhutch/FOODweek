require 'rails_helper'

RSpec.feature "Meal Plan", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user_id: user1.id) }

  describe "GET /meal_plans/1" do
    it " tells you you don't have any meals in your meal plan" do 
      login(user1)

      visit meal_plan_path(mealplan1)
      page.has_css?('div.no_recipes')
    end
  end
end
