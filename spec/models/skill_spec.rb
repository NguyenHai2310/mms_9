require "rails_helper"

RSpec.describe Skill, type: :model do
  let(:skill) {FactoryGirl.create :skill}
  subject {skill}

  describe "Test associations" do
    context "Test has_many" do
      it {is_expected.to have_many(:users).through(:skill_users)}
      it {is_expected.to have_many(:skill_users).dependent(:destroy)}
    end
  end

  describe "Test validates" do
    context "Create skill valid" do
      it {is_expected.to be_valid}
    end

    context "#name" do
      before {subject.name = ""}
      it {is_expected.to have(1).error_on :name}
    end
  end
end
