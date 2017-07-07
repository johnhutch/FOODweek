require 'rails_helper'

RSpec.describe MealPlan, type: :model do
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
  let(:recipe3) { FactoryGirl.create(:recipe, user: user1, ingredients_block: %Q|2 cloves garlic, finely chopped| ) }
  let(:recipe_unitless_1) { FactoryGirl.create(:recipe, user: user1, ingredients_block: "1 apple") }
  let(:recipe_unitless_2) { FactoryGirl.create(:recipe, user: user1, ingredients_block: "3 apples") }
  let(:recipe5) { FactoryGirl.create(:recipe, user: user1, ingredients_block: "4 pounds of apples") }
  let(:recipe6) { FactoryGirl.create(:recipe, user: user1, ingredients_block: "4 grams of apples") }

  let(:recipe7) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe8) { FactoryGirl.create(:recipe, user: user1) }
  let(:recipe9) { FactoryGirl.create(:recipe, user: user1) }

  let(:mealplan1) { FactoryGirl.create(:meal_plan, user: user1) }

  it "doesn't crash when subtracting a recipe with a weird unit" do
    mealplan1.recipes << recipe1
    mealplan1.recipes.delete(recipe1)
		expect(mealplan1).to be_valid
	end

  it "doesn't invent weird units" do
    mealplan1.recipes << recipe3
    ingredient = mealplan1.recipes.first.ingredients.first
    expect(ingredient.unit).to be_nil
  end

  it "doesn't crash when trying to add and subtract incompatible units" do
    mealplan1.recipes << recipe1
    mealplan1.recipes << recipe2
    mealplan1.recipes.delete(recipe2)
    expect(mealplan1).to be_valid
  end

  it "creates a user's grocery list when adding to the mealplan" do
    mealplan1.recipes << recipe1
    expect(mealplan1.user.grocery_list).to be_valid
  end

  it "adds a recipe's ingredients to a user's grocery list when adding a recipe to a user's mealplan" do
    mealplan1.recipes << recipe1
    list_ing = mealplan1.user.grocery_list.ingredients.first 
    expect(list_ing.unitized_amount).to eq recipe1.ingredients.first.unitized_amount
  end

  it "sums a recipe's ingredients to a user's grocery list when adding a recipe to a user's mealplan" do
    mealplan1.recipes << recipe1
    mealplan1.recipes << recipe2
    list_ing = mealplan1.user.grocery_list.ingredients.first
    expect(list_ing.amount).to eq (recipe1.ingredients.first.amount.to_i + recipe2.ingredients.first.amount.to_i).to_s
  end

  it "sums a recipe's unitless ingredients to a user's grocery list when adding a recipe to a user's mealplan" do
    mealplan1.recipes << recipe_unitless_1
    mealplan1.recipes << recipe_unitless_2
    list_ing = mealplan1.user.grocery_list.ingredients.first
    expect(list_ing.amount).to eq (recipe_unitless_1.ingredients.first.amount.to_i + recipe_unitless_2.ingredients.first.amount.to_i).to_s
  end

  it "tries to sum a unitless with a unit'd ingredient, but can't, so it just adds the unitless one" do
    mealplan1.recipes << recipe_unitless_2
    mealplan1.recipes << recipe5
    list_ing = mealplan1.user.grocery_list.ingredients.last
    expect(list_ing.unitized_amount).to eq recipe5.ingredients.first.unitized_amount
  end

  it "subtracts compatibly unit'd ingredients from a user's grocery list when a recipe is removed from their meal plan." do
    mealplan1.recipes << recipe5
    mealplan1.recipes << recipe6
    mealplan1.recipes.delete(recipe5)
    expect(mealplan1.user.grocery_list.ingredients.first.unitized_amount).to eq recipe6.ingredients.first.unitized_amount
  end

  it "subtracts compatibly unitless ingredients from a user's grocery list when a recipe is removed from their meal plan." do
    mealplan1.recipes << recipe_unitless_1
    mealplan1.recipes << recipe_unitless_2
    mealplan1.recipes.delete(recipe_unitless_1)
    expect(mealplan1.user.grocery_list.ingredients.first.unitized_amount).to eq recipe_unitless_2.ingredients.first.unitized_amount
  end

  it "skips incompatibly unit'd ingredients on from a user's grocery list when a recipe is removed from their meal plan, and just removes the correct ingredient." do
    mealplan1.recipes << recipe5
    mealplan1.recipes << recipe_unitless_1
    mealplan1.recipes.delete(recipe5)
    expect(mealplan1.user.grocery_list.ingredients.first.unitized_amount).to eq recipe_unitless_1.ingredients.first.unitized_amount
    expect(mealplan1.user.grocery_list.ingredients.first.unitized_amount).to_not eq recipe5.ingredients.first.unitized_amount
  end

  it "doesn't completely wipe out the grocery list in our meal plan feature spec scenario" do
    mealplan1.recipes << recipe7
    mealplan1.recipes << recipe9
    mealplan1.recipes.delete(recipe7)
    expect(mealplan1.user.grocery_list.ingredients).to contain_one_or_more_records_that(have_attributes(
      :unit => recipe7.ingredients.first.unit,
      :amount => recipe7.ingredients.first.amount,
      :name => recipe7.ingredients.first.name)
    )
  end

end
