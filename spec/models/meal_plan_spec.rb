require 'rails_helper'

RSpec.describe GroceryList, type: :model do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe1) { FactoryGirl.create(:recipe, user: user1, ingredients_block: %Q|5 tbsp soy sauce
                                     4 tbsp mild or hot chili powder
                                     3 tbsp five-spice powder
                                     2 tbsp light muscovado sugar
                                     2 cloves garlic, finely chopped
                                     4 cm piece of fresh ginger, peeled and finely chopped
                                     6 1/2 lbs boneless pork shoulder, rind removed|) }
  let(:recipe2) { FactoryGirl.create(:recipe, user: user1, ingredients_block: %Q|5 tbsp soy sauce
                                     4 grams mild or hot chili powder
                                     6 1/2 lbs boneless pork shoulder, rind removed|) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user: user1) }

  it "doesn't crash when subtracting a recipe with a weird unit" do
    mealplan1.recipes << recipe1
    mealplan1.recipes.delete(recipe1)
		expect(mealplan1).to be_valid
	end

  it "doesn't crash when trying to add incompatible units" do
    mealplan1.recipes << recipe1
    mealplan1.recipes << recipe2
		expect(mealplan1).to be_valid
  end

end
