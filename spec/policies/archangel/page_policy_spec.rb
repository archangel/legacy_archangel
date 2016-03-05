require "rails_helper"

module Archangel
  RSpec.describe PagePolicy, type: :policy do
    subject { PagePolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:user) }

    context "for a user" do
      it { should permit(:index) }
      it { should permit(:show) }
      it { should permit(:create) }
      it { should permit(:new) }
      it { should permit(:update) }
      it { should permit(:edit) }
      it { should permit(:destroy) }
    end

    context "for a manager" do
      it { should permit(:index) }
      it { should permit(:show) }
      it { should permit(:create) }
      it { should permit(:new) }
      it { should permit(:update) }
      it { should permit(:edit) }
      it { should permit(:destroy) }
    end

    context "for an admin" do
      it { should permit(:index) }
      it { should permit(:show) }
      it { should permit(:create) }
      it { should permit(:new) }
      it { should permit(:update) }
      it { should permit(:edit) }
      it { should permit(:destroy) }
    end
  end
end
