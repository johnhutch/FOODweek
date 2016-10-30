require 'rails_helper'

RSpec.feature "User Dashboard", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user_id: user1.id) }

  describe "GET /dashboard/" do
    it " tells you you don't have any meals in your meal plan" do 
      login(user1)

      expect(page).to have_selector('h1.test-dash_header')
    end

    it " shows user scenario 1 for a user with no recipes or meal plans" do 
        login(user1)

        expect(page).to have_selector('.test__user-scen-1')
    end 
  end
end
