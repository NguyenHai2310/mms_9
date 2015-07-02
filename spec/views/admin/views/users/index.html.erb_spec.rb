require "rails_helper"

describe "admin/users/index.html.erb" do
  before do
    20.times {FactoryGirl.create :user}
    @users = User.paginate page: params[:page], per_page: Settings.size_per_page
    render
    subject {rendered}
  end

  context "request #index" do
    it {expect(controller.request.path_parameters[:controller]).to eq "admin/users"}
    it {expect(controller.request.path_parameters[:action]).to eq "index"}
  end

  context "show list users" do
    User.paginate(page: 1).each do |user|
      it {is_expected.to have_selector("li", text: user.username, text: "Detail")}
      it {is_expected.to have_css("div.paginate")}
    end
  end
end
