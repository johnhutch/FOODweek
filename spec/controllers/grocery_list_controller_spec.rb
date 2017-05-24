require 'rails_helper'

RSpec.describe GroceryList, type: :request do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe2) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe3) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user_id: user1.id) }

  describe "GET /grocery_list" do
    it "displays the user's grocery list" do
      login(user1)
      mealplan1.recipes << recipe

      get grocery_list_path
      expect(response).to render_template(:index)
    end

		it "redirects to login if no session is found" do 
      get grocery_list_path
      expect(response).to redirect_to(new_user_session_url)
    end
  end

  describe "POST /grocery_list/add_ingredient" do
		it "redirects to login if no session is found" do
      mealplan1.recipes << recipe

      expect { 
        post add_ingredient_to_grocery_list_path, params: { :ingredient => { :ingredient_string => "1/4 cup of butter" } } 
      }.to_not change(Ingredient, :count)
      expect(response).to redirect_to(new_user_session_url)
    end

		it "parses the submitted ingedient and adds to the grocery list" do
      login(user1)
      mealplan1.recipes << recipe

      post add_ingredient_to_grocery_list_path, params: { :ingredient => { :ingredient_string => "1/4 cup of butter" } }
      expect(response).to redirect_to(dashboard_path)
    end
  end

  describe "POST /grocery_list/remove_ingredient" do
		it "parses the submitted ingedient and removes it from the grocery list" do
      login(user1)
      mealplan1.recipes << recipe
      ingredient = recipe.ingredients.first

      post remove_ingredient_from_grocery_list_path, params: { :id => ingredient.id } 
      expect(response).to redirect_to(dashboard_path)
      expect(flash[:notice]).to match "#{ingredient.name} #{I18n.t('grocery_list.ingredient_added')}"
    end

		it "redirects to login if no session is found" do
      mealplan1.recipes << recipe

      expect { 
        post remove_ingredient_from_grocery_list_path, params: { :ingredient => { :id => mealplan1.recipes.first.ingredients.first.id } } 
      }.to_not change(Ingredient, :count)
      expect(response).to redirect_to(new_user_session_url)
    end
  end
end
