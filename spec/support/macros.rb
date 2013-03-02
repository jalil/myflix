def set_current_user(user)
   session[:user_id] = user.id
end


def current_user
  User.find(session[:user_id])
end

def clear_user 
  session[:user_id] = nil
end
