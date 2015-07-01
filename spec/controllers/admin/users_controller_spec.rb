require "rails_helper"

<<<<<<< HEAD
RSpec.describe Admin::UsersController do
=======
RSpec.describe Admin::UsersController, type: :controller do
>>>>>>> test controller
  before do
    @admin_user = FactoryGirl.create :user, role: "admin"
    @other_user = FactoryGirl.create :user, role: "member"
    sign_in @admin_user
  end

  describe "GET #index" do
    context "admin GET #index success" do
      before {get :index}
      it {expect(response).to render_template "index"}
    end

    context "member GET #index" do
      before do
        sign_in @other_user
        get :index
      end
      it {expect(response).to redirect_to root_path}
      it {expect(flash[:alert]).to eq "isn't admin!"}
    end
  end

  describe "POST #create" do
    context "with valid attribute" do
      before {post :create, user: FactoryGirl.attributes_for(User)}
      it {expect(response).to redirect_to admin_users_path}
      it {expect(flash[:success]).to be_present}
      it {expect{post :create, user: FactoryGirl.attributes_for(User)}
        .to change(User, :count).by(1)}
    end

    context "with invalid attribute" do
      before {post :create, user: {username: ""}}
      it {expect(response).to render_template "new"}
    end
  end

  describe "GET #show" do
    before {get :show, id: @other_user.id}
<<<<<<< HEAD
    it {expect(response).to render_template "show"}
=======
    it{expect(response).to render_template "show"}
>>>>>>> test controller
  end

  describe "DELETE #destroy" do
    it "should response index page after delete user" do
      delete :destroy, id: @other_user.id
      expect(response).to redirect_to admin_users_path
    end
  end
end
