require "rails_helper"

module Archangel
  RSpec.describe CommentPolicy, type: :policy do
    subject { CommentPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:comment) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
  end
end
