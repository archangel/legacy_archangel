require "rails_helper"

module Archangel
  RSpec.describe PostPolicy, type: :policy do
    subject { PostPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:post) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end
end
