require "rails_helper"

module Archangel
  RSpec.describe TagPolicy, type: :policy do
    subject { TagPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:tag) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end
end
