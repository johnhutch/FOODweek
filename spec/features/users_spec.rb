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
      expect(page).to have_content( I18n.t('devise.registrations.signed_up_but_unconfirmed') )
    end
  end


  describe "user1 password recovery" do
  #   As a user who forgot my password
  #   I want to recover my site access easily
  # 
    specify "email recovery of a new password" do
      user1
      visit new_user_session_path
      click_on I18n.t('devise.shared_links.forgot_password')
      fill_in "Email", :with => user1.email
      click_on I18n.t('devise.passwords.send_reset')

      original_password = user1.password
      current_email_address = user1.email
      # EmailSpec::EmailViewer::save_and_open_all_raw_emails
      expect(unread_emails_for(user1.email)).to be_present
      open_email user1.email, :with_subject => "Reset password instructions"
      click_first_link_in_email
      expect(page).to have_selector(".test--change_password")
      fill_in "user_password", :with => "newpass"
      fill_in "user_password_confirmation", :with => "newpass"
      click_button I18n.t('devise.passwords.submit_button')
      expect(page).to have_content I18n.t('devise.passwords.updated') 
      click_link I18n.t('devise.nav.log_out')

      # i should not be able to log in with the old password
      visit new_user_session_path
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with =>  original_password
      click_button "Log in"
      expect(page).to have_content I18n.t('devise.failure.invalid', authentication_keys: "Email")

      # I should be able to log in with the new password
      visit new_user_session_path
      fill_in "user_email", :with => user1.email
      fill_in "user_password", :with => "newpass"
      click_button "Log in"
      expect(page).to have_content I18n.t('devise.sessions.signed_in')
    end
  end
end
