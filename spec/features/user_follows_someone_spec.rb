require 'spec_helper'

feature "User follows someone" do

  given(:joe) { Fabricate(:user) }
  given(:mike) { Fabricate(:user) }
  given(:monk) { Fabricate(:video) }

  background do
    Fabricate(:review, video: monk, user: mike)
  end

  scenario 'happy path' do
    sign_in(joe)
    visit home_path

    click_on_video(monk)
    click_link mike.full_name
    click_link 'Follow'
    click_link 'People'
    unfollow_that_person
    mike_should_not_be_on_the_page
  end

  def unfollow_that_person
    find("a[data-method='delete']").click
  end

  def mike_should_not_be_on_the_page
    page.should_not have_content(mike.full_name)
  end

end
