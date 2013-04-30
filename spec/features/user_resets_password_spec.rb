require 'spec_helper'

feature 'User resets password' do
  given(:alice) { Fabricate(:user) }
  given!(:old_token) { alice.token }

  scenario "user resets password successfully" do
    visit sign_in_path
    click_link "Forgot Password?"
    fill_in "Email Address", with: alice.email
    click_button "Send Email"
    an_email_should_be_sent_to(alice.email)
    email_should_include_user_token(alice)

    visit new_password_reset_path(alice.token)

    fill_in "New Password", with: 'abcde'
    click_button "Reset Password"
    page.should have_content "Password has been reset!"

    fill_in "Email Address", with: alice.email
    fill_in "Password", with: 'abcde'
    click_button "Sign in"
    page.should have_content "Welcome, #{alice.full_name}"

    visit new_password_reset_path(old_token)
    page.should have_content "Your reset password link is expired."

    clear_emails
  end

end

def email_should_include_user_token(user)
  ActionMailer::Base.deliveries.last.body.should include(user.token)
end
