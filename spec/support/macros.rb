def set_current_user(user)
   session[:user_id] = user.id
end


def current_user
  User.find(session[:user_id])
end

def clear_user 
  session[:user_id] = nil
end
def set_current_user(user)
  session[:user_id] = user.id
end

def sign_in(user)
  visit sign_in_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password
  click_button "Sign in"
end

def click_on_video(video)
  find("section.content a[href='#{video_path(video)}']").click
end

def an_email_should_be_sent_to(email)
  ActionMailer::Base.deliveries.last.to.should == [email]
end

def clear_emails
  ActionMailer::Base.deliveries.clear
end
