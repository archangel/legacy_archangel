require "rails_helper"

module Archangel
  RSpec.describe CategoryPolicy, type: :policy do
    subject { CategoryPolicy.new(user, record) }

    let(:user) { create(:user) }
    let(:record) { create(:category) }

    it { should permit(:index) }
    it { should permit(:show) }
    it { should permit(:create) }
    it { should permit(:new) }
    it { should permit(:update) }
    it { should permit(:edit) }
    it { should permit(:destroy) }
    it { should permit(:autocomplete) }
  end
end
