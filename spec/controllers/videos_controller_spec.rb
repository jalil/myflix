require 'spec_helper'

describe VideosController do
  describe "GET #index" do
    it "sets the @categories variable" do
      title = Category.create(title: "monk")

      get :index
      assigns(:categories).should == [title]
    end

    it "renders the :index template" do
      get :index
      response.should render_template :index
    end
  end

  describe "Get #show" do
    it "assigns the requested video to @video" do
      video = Video.create(params[:video])
      get :show, id: video
      assigns(:video).should eq video
    end

    it "renders the :show template" do
      video = Video.create(:video)
      get :show, id:video
      response.should render_template :show
    end
  end
end
