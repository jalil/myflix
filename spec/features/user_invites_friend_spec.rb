require 'spec_helper'

feature 'User invites friend' do
  given(:alice) { Fabricate(:user) }
  scenario "User successfully invites friend to join myflix" do
    sign_in(alice)
    visit new_invitation_path
    fill_in "Friend's Name", with: "Chris Lee"
    fill_in "Friend's Email", with: "chris@example.com"
    fill_in "Invitation Message", with: "Hello please join this"
    click_button "Send Invitation"

    open_email 'chris@example.com'
    current_email.click_link 'Click here to accept this invitation'

    fill_in "Password", with: '123'

    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "4 - April", from: '#date_month'
    select "2014", from: '#date_year'

    click_button 'Sign Up'

    fill_in "Email Address", with: "chris@example.com"
    fill_in "Password", with: "123"
    click_button "Sign in"

    page.should have_content "Welcome, Chris Lee"
    click_link "People"
    page.should have_content alice.full_name

    visit sign_out_path
    sign_in(alice)
    click_link "People"
    page.should have_content "Chris Lee"

    clear_emails
  end
end
