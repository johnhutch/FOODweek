require 'rails_helper'

RSpec.feature "User Dashboard", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user_id: user1.id) }

  describe "GET /dashboard/" do
    it " displays the dashboard to a logged-in user." do 
      login(user1)

      visit dashboard_path
      expect(page).to have_selector('.panel--foodweek')
    end

    it " shows appropriate message for a user with no meal plan." do 
        login(user1)

        visit dashboard_path
        expect(page).to have_selector('.message--no-meal-plan')
    end 

    it " shows appropriate message for user with no recipes." do 
        recipe
        login(user1)

        visit dashboard_path
        expect(page).to have_selector('.message--no-meal-plan')
    end 
  end
end
