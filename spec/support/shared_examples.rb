shared_examples "require_sign_in" do
  it "redirects to the sign in page" do
    session[:user_id] = nil
    action
    response.should redirect_to sign_in_path
  end
end

shared_examples "tokenable" do
  it "generates a token before create" do
    object.token.should_not be_empty
  end
end
