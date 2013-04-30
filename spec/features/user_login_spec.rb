require 'spec_helper'

feature "User signs in and see their name in the home page" do
  background do
    Fabricate(:user, email: "joe@example.com", password: "password", full_name: "Joe Doe")
  end

  scenario "user signs in with valid credentials" do
    visit sign_in_path
    fill_in "Email Address", with: "joe@example.com"
    fill_in "Password", with: "password"
    click_button "Sign in"
    page.should have_content "Welcome, Joe Doe"
  end
end
