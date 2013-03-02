require 'spec_helper'

feature "the sign in with username and password process"  do
  background  do 
    Fabricate(:user, email: "jalil@example.com", password:  "jalil", full_name: "Jalil Lastname")
  end

  scenario "logs  me in" do
    visit login_path
    fill_in "Email Address", :with => "jalil@example.com"
    fill_in "Password", :with => "jalil"
    click_button 'Sign in'
    page.should have_content "Welcome, Jalil Lastname"
  end
end
