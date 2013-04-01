require 'spec_helper'

feature 'User resets password' do
  given(:bob) { Fabricate(:user, email:"bob@example.com") }
  given!(:old_token) { bob.password_reset_token }

  scenario "user resets password successfully" do
    visit login_path
    click_link "Forgot your password?"
    fill_in "Email Address", with: bob.email
    click_button "Send Email"
    an_email_should_be_sent_to(bob.email)
    email_should_include_user_token(bob)

    visit new_password_reset_path(bob.password_reset_token)

    fill_in "New Password", with: 'abcde'
    fill_in "Password Confirmation", with: 'abcde'
    click_button "Reset Password"
    page.should have_content "Password has been reset!"

    fill_in "Email Address", with: bob.email
    fill_in "Password", with: 'abcde'
    click_button "Sign in"
    page.should have_content "Welcome, #{bob.full_name}"

    visit new_password_reset_path(old_token)
    page.should have_content "Your reset password link is expired."

    clear_emails
  end

end

def email_should_include_user_token(user)
  ActionMailer::Base.deliveries.last.body.should include(user.password_reset_token)
end
