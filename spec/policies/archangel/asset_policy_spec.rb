require "rails_helper"

module Archangel
  RSpec.describe AssetPolicy, type: :policy do
    subject { AssetPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:asset) }

    it { should permit(:create) }
  end
end
