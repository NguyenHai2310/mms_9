require "rails_helper"

RSpec.describe Admin::SkillsController do
  before do
    @admin_user = FactoryGirl.create :user, role: "admin"
    sign_in @admin_user
    @skill = FactoryGirl.create :skill
  end

  describe "get #index" do
    before {get :index}
    it {expect(response).to render_template "index"}
  end

  describe "get #new" do
    before {get :new}
    it {expect(response).to render_template "new"}
  end

  describe "POST #create" do
    context "with valid attribute" do
      before {post :create, skill: FactoryGirl.attributes_for(Skill)}
      it {expect(response).to redirect_to admin_skills_path}
      it {expect(flash[:success]).to be_present}
      it {expect{post :create, skill: FactoryGirl.attributes_for(Skill)}
        .to change(Skill, :count).by(1)}
    end

    context "with invalid attribute" do
      before {post :create, skill: {name: ""}}
      it {expect(response).to render_template "new"}
    end
  end

  describe "delete #destroy" do
    subject {delete :destroy, id: @skill.id}
    before {subject}
    it {expect(response).to redirect_to admin_skills_path}
    it {expect(flash[:success]).to eq "deleted!"}
  end
end
