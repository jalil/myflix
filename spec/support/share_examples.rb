shared_examples "render_template" do
  it "renders the template" do
    action
    response.should render_template template
  end
end

shared_examples "redirect_to" do
  it "redirects to the path" do
    action
    response.should redirect_to path
  end
end

shared_examples "require_sign_in" do 
  it "redirects to sign in page" do
    session[:user_id] = nil
    action
    response.should redirect_to login_path
  end
end
