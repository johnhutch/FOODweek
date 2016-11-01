require 'rails_helper'

RSpec.feature "User Dashboard", type: :feature do
  let(:user1) {FactoryGirl.create(:user)}
  let(:recipe) { FactoryGirl.create(:recipe, user: user1) }
  let(:mealplan1) { FactoryGirl.create(:meal_plan, user_id: user1.id) }

  describe "POST /users/sign_in" do
    it "logs the user in then logs out" do 
      user1
      visit new_user_session_path
      expect(page).to have_selector(".test-sign_in");
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with => user1.password
      click_button "Log in"
      expect(page).to have_content I18n.t('devise.sessions.signed_in')

      click_link I18n.t('devise.nav.log_out')
      expect(page).to have_content I18n.t('devise.sessions.signed_out')
    end
  end

  describe "POST /users/" do 
    it "signs a user up" do
      visit new_user_registration_path
      expect(page).to have_selector(".test-sign_up_form")
      fill_in "user_email", :with => "test@email.com"
      fill_in "user_password", :with => "secret"
      fill_in "user_password_confirmation", :with => "secret"
      click_button I18n.t('devise.registrations.submit_button')
      expect(page).to have_selector(".test-dash_header")
      expect(page).to have_content( I18n.t('devise.registrations.signed_up') )
    end
  end
end
